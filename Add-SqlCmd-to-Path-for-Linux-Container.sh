# script=https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/Add-SqlCmd-to-Path-for-Linux-Container.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash
SQL_SERVER_CONTAINER_NAME="${SQL_SERVER_CONTAINER_NAME:-}"
if [[ -z "$SQL_SERVER_CONTAINER_NAME" ]]; then
  echo "Abort. Variable SQL_SERVER_CONTAINER_NAME is not defined"
  exit 777
fi

tmp="{$TMPDIR:-/tmp}"
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
docker exec "$SQL_SERVER_CONTAINER_NAME" sqlcmd -? | head -2 || echo "OOPS. Missing sqlcmd on container '$SQL_SERVER_CONTAINER_NAME'"
