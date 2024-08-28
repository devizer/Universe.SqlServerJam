Param(
   [string] $remote,
   [string] $login,
   [string] $password,
   [string] $remoteFolder,
   [string[]] $files
)

# https://help.appveyor.com/discussions/problems/33606-try-to-deploy-sftp-to-sourceforge-error-cannot-connect-sftp-server-failed-to-negotiate-key-exchange-algorithm
# https://help.appveyor.com/discussions/problems/33606-try-to-deploy-sftp-to-sourceforge-error-cannot-connect-sftp-server-failed-to-negotiate-key-exchange-algorithm

function UrlEncode([string] $a) { 
  $ret = ""; $chars = $a.ToCharArray();
  foreach($c in $chars) { 
    $lower=$c.ToString().ToLower();
    if (($lower -ge "a" -and $lower -le "z") -or ($lower -ge "a" -and $lower -le "z") -or $lower -eq "." -or $lower -eq "-") { $ret += $c; } else { $ret += "%" + ([int]$c).ToString("X2"); }
  }
  $ret;
}

function Copy-via-SSH {
Param(
   [string] $remote,
   [string] $login,
   [string] $password,
   [string] $remoteFolder,
   [string[]] $files,
   [int] $timeout # not implemented
)
 $batchFile = "$($ENV:LOCALAPPDATA)\$(([Guid]::NewGuid()).ToString("N")).txt"
 try {
   Write-Host "BatchFile = [$batchFile]"
   $batch = @();
   $batch += "open sftp://$(UrlEncode $login):$(UrlEncode $password)@$($remote)/ -hostkey=`"acceptnew`""
   foreach($file in $files) {
     $batch += "put `"$($file)`" `"$remoteFolder`""
   }
   $batch += "exit$([Environment]::NewLine)"
   $utf8=new-object System.Text.UTF8Encoding($false); 
   [System.IO.File]::WriteAllText($batchFile, ([string]::Join([Environment]::NewLine,$batch)), $utf8);
   & cmd.exe @("/c", "winscp.exe", "/script=`"$batchFile`"")
   echo "[Scp] Exit Code is $LASTEXITCODE"
 } finally {
   [System.IO.File]::Delete($batchFile);
 }
}

# UrlEncode "Hello, World; I'm a hero"
Copy-via-SSH -Remote $remote -Login $login -Password $password -RemoteFolder $RemoteFolder -Files $Files
