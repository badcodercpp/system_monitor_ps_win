Function CheckNetworkLatency {
    param(
        [parameter(Mandatory=$true)]
        [String] $compName
    )
    $result=Test-Connection "10.82.42.4" -Quiet
    Write-Host $result
}

CheckNetworkLatency "10.82.42.4"