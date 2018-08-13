# Powershell Verion Required PS ^4.0.0
# author Ajay Jha

Function GetSqlErrorFromEventLog {
    param(
        [parameter(Mandatory=$true)]
        [String] $logName,
        [parameter(Mandatory=$true)]
        [String] $entryType,
        [parameter(Mandatory=$true)]
        [String] $dbName
    )
    $log=Get-EventLog -LogName "$logName" -EntryType "$entryType" | Where-Object {$_.source -like "*$dbName*"} | Select-Object Index,TimeGenerated,Source,InstanceId,Message,EntryType | ConvertTo-Json -Compress
    Write-Host $log
}

GetSqlErrorFromEventLog "application" "Error" "SQL"

