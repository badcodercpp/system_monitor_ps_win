Function Get-CPULoad {
    [cmdletbinding()]
    param(
    )
    $load = Get-WmiObject win32_processor | select LoadPercentage
    return $load.LoadPercentage
}

$load=Get-CPULoad
Write-Host "$load %"