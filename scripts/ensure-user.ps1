$userFile = Join-Path $PSScriptRoot "..\.user.yaml"
if (-not (Test-Path $userFile)) {
    $id = [guid]::NewGuid().ToString()
    "id: $id" | Out-File -FilePath $userFile -Encoding utf8
    Write-Host "Created .user.yaml with a new developer id."
} else {
    Write-Host ".user.yaml already exists-skipping."
}