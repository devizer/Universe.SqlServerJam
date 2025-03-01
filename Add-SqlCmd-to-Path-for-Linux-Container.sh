#!/bin/bash
# script=https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/Add-SqlCmd-to-Path-for-Linux-Container.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash
set -eu; set -o pipefail;
SQL_SERVER_CONTAINER_NAME="${SQL_SERVER_CONTAINER_NAME:-}"
if [[ -z "$SQL_SERVER_CONTAINER_NAME" ]]; then
  echo "Abort. Variable SQL_SERVER_CONTAINER_NAME is not defined"
  exit 777
fi

tmp="${TMPDIR:-/tmp}"
echo '#!/bin/bash
set -eu; set -o pipefail;
if [[ -x /opt/mssql-tools/bin/sqlcmd ]]; then
  /opt/mssql-tools/bin/sqlcmd "$@"
  exit 0
else 
  exe="$(ls -1 /opt/mssql-tools*/bin/sqlcmd 2>/dev/null)"
  if [[ -n "$exe" ]]; then
    "$exe" "$@"
    exit 0
  fi
fi
echo "[sqlcmd shell] Error. Not found \"/opt/mssql-tools*/bin/sqlcmd\""
exit 7
' > /tmp/sqlcmd-smart-launcher.sh
chmod +x /tmp/sqlcmd-smart-launcher.sh

docker cp /tmp/sqlcmd-smart-launcher.sh "$SQL_SERVER_CONTAINER_NAME":/usr/local/bin/sqlcmd
docker exec "$SQL_SERVER_CONTAINER_NAME" sqlcmd -? 2>/dev/null | head -2 || true


function get_global_seconds() {
  theSYSTEM="${theSYSTEM:-$(uname -s)}"
  if [[ ${theSYSTEM} != "Darwin" ]]; then
      # uptime=$(</proc/uptime);                                # 42645.93 240538.58
      uptime="$(cat /proc/uptime 2>/dev/null)";                 # 42645.93 240538.58
      if [[ -z "${uptime:-}" ]]; then
        # secured, use number of seconds since 1970
        echo "$(date +%s)"
        return
      fi
      IFS=' ' read -ra uptime <<< "$uptime";                    # 42645.93 240538.58
      uptime="${uptime[0]}";                                    # 42645.93
      uptime=$(LC_ALL=C LC_NUMERIC=C printf "%.0f\n" "$uptime") # 42645
      echo $uptime
  else 
      # https://stackoverflow.com/questions/15329443/proc-uptime-in-mac-os-x
      boottime=`sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//g'`
      unixtime=`date +%s`
      timeAgo=$(($unixtime - $boottime))
      echo $timeAgo
  fi
}

if [[ -n "${SQL_PING_PARAMETERS:-}" ]]; then
  SQL_PING_TIMEOUT="${SQL_PING_TIMEOUT:-30}"
  echo "Waiting for SQL Server at container '$SQL_SERVER_CONTAINER_NAME' up to $SQL_PING_TIMEOUT seconds"
  startAt="$(get_global_seconds)"
  ok='';
  VerFile="$(mktemp || echo "/tmp/$RANDOM")"
  while [ 1 -eq 1 ]; do
    query="Set NoCount On; Select Cast(Cast(SERVERPROPERTY('PRODUCTVERSION') as nvarchar(100)) + ' ' + Cast(SERVERPROPERTY('EDITION') as nvarchar(300)) as nvarchar(100));"
    # docker exec -t "$SQL_SERVER_CONTAINER_NAME" sqlcmd ${SQL_PING_PARAMETERS:-} -Q "$query" || ok='true';
    docker exec -t "$SQL_SERVER_CONTAINER_NAME" bash -e -c "sqlcmd -h -1 ${SQL_PING_PARAMETERS:-} -Q \"$query\"" > "$VerFile" 2>/dev/null && ok='true';
    now="$(get_global_seconds)"
    elapsed=$((now - startAt))
    if [[ "$ok" == true ]]; then break; fi
    if [ "$elapsed" -ge "$SQL_PING_TIMEOUT" ]; then break; fi
    sleep 1
  done
  if [[ -n "$ok" ]]; then
    echo "SQL Server Succesfully connected ($elapsed seconds)"
    ver="$(cat "$VerFile" | head -1)"
    ver="$(echo $ver | tr -d '\r' | tr -d '\n' | tr -d '\r')"
    ver="${ver%%[[:space:]]}"
    echo "SQL Server Version: '$ver'"
  else
    echo "Warning! Unable to connect to SQL Server ($elapsed seconds)"
  fi
fi
