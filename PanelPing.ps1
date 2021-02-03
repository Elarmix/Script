#----------Variable----------#
$ServerIP = @("127.0.0.1")
$ServerName = @("LocalHost")
$ErrorLevel = @("0")

#----------Function----------#
function Show-PingError {
    param (
        $ServerName
    )

    $Time = Get-Date -UFormat "%R" 
    $wshell = New-Object -ComObject Wscript.Shell
    $wshell.Popup("Connection error to server $ServerName since $Time")
}

#----------Script----------#
foreach ($IP in $ServerIP) {
    for ($i = 0; $i -lt 1; $i++) {
        $PingValue = Test-Connection $IP -count 1 -Quiet
        if ($PingValue -eq $FALSE -and $ErrorLevel -eq "0") {
            Show-PingError -ServerName $ServerName[$i]
            $ErrorLevel[$i] = 1
        }
        if ($PingValue -eq $TRUE -and $ErrorLevel -eq "1") {
            $ErrorLevel[$i] = 0
        }
    }
}

