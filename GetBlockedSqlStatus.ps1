Function Get-BlockedSQLProcess {
param ($ComputerName=$env:computername,
$MainInstance = (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances
) 
$status=1
foreach($Servers in $ComputerName)
    {

        $Query =   'select @@servername as Servername, blocking_session_id BlockingSessionId ,db_name(dbid) as DBName, Start_Time,DATEDIFF(Minute,start_time,getdate())/60 as HoursTaken,  DATEDIFF(Minute,start_time,getdate()) as MinuteTaken,Command   from sys.dm_exec_requests cross apply sys.dm_exec_sql_text (sql_handle) WHERE blocking_session_id <> 0'
       
        $servername = $ComputerName+"\"+$MainInstance
    
        $Result = Invoke-Sqlcmd ($Query) -ServerInstance $servername

            foreach ($Item in $Result)
            {

                    if ($Item.HoursTaken > 1)
                    {
                      $status=0
                    }
                    
            }
           
           
    }
    return $status
}

$status=Get-BlockedSQLProcess 

Write-Host $status