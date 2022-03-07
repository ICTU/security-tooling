# Example run: ./security_dependencycheck.ps1 c:/sources/ c:/reports/

Param(
  [string]$sourcepath,
  [string]$reportpath
)

$temppath = 'c:\temp\'
$dotnetsetupfile = $temppath + 'dotnet-install.ps1'
$zipfile =  $temppath + 'dependency-check.zip'
$datapath =  $temppath + 'dependency-check-data\'
$githubLatestReleases = "https://api.github.com/repos/jeremylong/DependencyCheck/releases/latest"

Write-Host $zipfile $sourcepath $datapath
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if(!(Test-Path "$env:programfiles/dotnet/")){
    Write-Host "Dotnet not found, downloading..."
    Invoke-WebRequest https://dot.net/v1/dotnet-install.ps1 -OutFile $dotnetsetupfile
    Write-Host "Installing..."
    & $dotnetsetupfile
}

if(!(Test-Path $datapath)){
    Write-Host "Dependency Check data folder not found, creating..."
    New-Item -Path $datapath -ItemType "directory"
}

if(!(Test-Path ($temppath+'\dependency-check'))){
    Write-Host "Dependency check is not installed, downloading..."

    $Uri = ((Invoke-WebRequest $gitHubLatestReleases) | ConvertFrom-Json).assets[0].browser_download_url  

    Invoke-WebRequest $Uri -OutFile $zipfile
    Write-Host "Extracting..."
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $temppath)
}

if(!(Test-Path $reportpath))
{
    Write-Host "Report path does not exist, creating..."
    New-Item -ItemType Directory -Force -Path $reportpath
}

$cmd = "$temppath\dependency-check\bin\dependency-check.bat -d $datapath -s $sourcepath -o $reportpath -f ALL"
Write-Host "Running depenceny-check: $cmd"

cmd /C $cmd

Write-Host "Done..."
