function SQL-BlockedStatus
{    
    [cmdletbinding()]
    Param
    (
        #[String]  
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)] $ConnectionString
    )
    
        #$sqlConnection = New-Object -TypeName System.Data.SqlClient.SqlConnection $ConnectionString;
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection($ConnectionString);

        
        

        $sqlCommand= New-Object System.Data.SqlClient.SqlCommand('select @@servername as Servername, blocking_session_id BlockingSessionId ,db_name(dbid) as DBName, Start_Time,DATEDIFF(Minute,start_time,getdate())/60 as HoursTaken,  DATEDIFF(Minute,start_time,getdate()) as MinuteTaken,Command   from sys.dm_exec_requests cross apply sys.dm_exec_sql_text (sql_handle) WHERE blocking_session_id <> 0',$sqlConnection);
        $sqlConnection.Open();
        $reader=$sqlCommand.ExecuteReader();
        
        while($reader.Read())
        {
            Write-Host "Ajay"
            Write-Host $reader.Servername
            Write-Host $reader[0];
        }

        Write-Host $reader

        $reader | ft
        $reader | %{
            Write-Host $_.Servername
        }







        
        $sqlConnection.Close();
       
        
}


$status = SQL-BlockedStatus "Data Source=10.82.42.4\PORTALDB,1113;Initial Catalog=KEDB;User ID=K1_ITSDEVAZRDB001;password=Password!"

Write-Host $status