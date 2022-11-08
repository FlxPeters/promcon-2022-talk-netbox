BeforeAll {
  . $PSScriptRoot/demo.ps1

  # Create a new file for testing
  function New-File([string]$FilePath, [string]$Content = "Testfile") {
    $dirPath = Split-Path -Path $FilePath
    # Create path if not exists
    If(-Not (Test-Path $dirPath)){
      New-Item -Path $dirPath -ItemType Directory -Force
    }
    New-Item -Path $FilePath -ItemType File -Force
    Set-Content $FilePath -value $Content
  }
}


describe("Get-FilesMetric"){
  BeforeAll {
    # Create a anchor file
    New-File(Join-Path -Path "TestDrive:\" -ChildPath "tmp/foo/bar.txt")
  }
  It "Should return 1 for an existing file" {
    $metric = Get-FileMetrics("TestDrive:\")
    # The first one should exist
    $metric[0] | Should -Be 'file{path="TestDrive:/tmp/foo"} 1'
  }
}