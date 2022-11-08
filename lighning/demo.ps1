# Import Prometheus powershell modules with powershell package manager
Import-Module PrometheusExporter

function collector () {
    $TotalFilesDesc   = New-MetricDescriptor -Name "files_total" -Type counter -Help "Total amount of files in a folder"
    $Path = "/tmp/foo"

    if (Test-Path -Path $Path){
      # Collect marker file counts
      $TotalFiles = @(Get-ChildItem  -Path $Path -Recurse | Where-Object {$_.Extension -eq ".txt"} | Select-Object FullName).count
    }else{
      # Set to default 0
      $TotalFiles = 0
    }

    @(
        New-Metric -MetricDesc $TotalFilesDesc -Value $TotalFiles -Labels ($Path)
    )
}

$exp = New-PrometheusExporter -Port 9700
Register-Collector -Exporter $exp -Collector $Function:collector
$exp.Start()