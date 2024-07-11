# Prepare the environment
Write-Host "Preparing the environment ..."

if (-Not (Test-Path -Path "volumes")) {
    New-Item -ItemType Directory -Path "volumes"
}

Set-Location -Path "volumes"

if (-Not (Test-Path -Path "poc-mini-fileserver")) {
    Write-Host "Cloning poc-mini-fileserver from GitHub..."
    git clone https://github.com/vatoer/poc-mini-fileserver.git
}

if (-Not (Test-Path -Path "legacy-edispo")) {
    Write-Host "Cloning legacy-edispo from GitHub..."
    git clone https://github.com/vatoer/legacy-edispo.git
}

if (-Not (Test-Path -Path "eoffice-perwakilan")) {
    Write-Host "Cloning eoffice-perwakilan from GitHub..."
    git clone https://github.com/vatoer/eoffice-perwakilan.git
}
else {
    Set-Location -Path "eoffice-perwakilan"
    Write-Host "Pulling latest changes for eoffice-perwakilan from GitHub..."
    git pull
}
