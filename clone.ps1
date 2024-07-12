# Prepare the environment
Write-Host "Preparing the environment ..."

# Change to the volumes directory or create it if it doesn't exist
if (-Not (Test-Path -Path "volumes")) {
    New-Item -ItemType Directory -Path "volumes"
}

Set-Location -Path "volumes"

# Clone or pull poc-mini-fileserver repository
if (-Not (Test-Path -Path "poc-mini-fileserver")) {
    Write-Host "Cloning poc-mini-fileserver from GitHub..."
    git clone https://github.com/vatoer/poc-mini-fileserver.git
}
else {
    Set-Location -Path "poc-mini-fileserver"
    Write-Host "Pulling latest changes for poc-mini-fileserver from GitHub..."
    git pull
    Set-Location -Path ".."
}

# Clone or pull legacy-edispo repository
if (-Not (Test-Path -Path "legacy-edispo")) {
    Write-Host "Cloning legacy-edispo from GitHub..."
    git clone https://github.com/vatoer/legacy-edispo.git
}
else {
    Set-Location -Path "legacy-edispo"
    Write-Host "Pulling latest changes for legacy-edispo from GitHub..."
    git pull
    Set-Location -Path ".."
}

# Clone or pull eoffice-perwakilan repository
if (-Not (Test-Path -Path "eoffice")) {
    Write-Host "Cloning eoffice-perwakilan from GitHub..."
    git clone https://github.com/vatoer/eoffice-perwakilan-docker.git eoffice
}
else {
    Set-Location -Path "eoffice"
    Write-Host "Pulling latest changes for eoffice-perwakilan from GitHub..."
    git pull
    Set-Location -Path ".."
}

# Return to the volumes directory
Set-Location -Path ".."
