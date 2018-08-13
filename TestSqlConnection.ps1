function Test-SQLConnection 
{    
     
    Param
    (
        #[String]  
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)] $ConnectionString
    )
    $status=0
    try
    {
    
        #$sqlConnection = New-Object -TypeName System.Data.SqlClient.SqlConnection $ConnectionString;
        $sqlConnection = [System.Data.SqlClient.SqlConnection] $ConnectionString;

        
        $sqlConnection.Open();
        
        $sqlConnection.Close();
       
        $status=1
        return $status;
    }
    catch
    {
        return $status;
    }
}


$status = Test-SQLConnection "Data Source=10.82.42.4\PORTALDB,1113;Initial Catalog=KEDB;User ID=K1_ITSDEVAZRDB001;password=Password!"

Write-Host $status