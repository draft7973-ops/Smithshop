Clear-Host

# ===== CONFIG =====
$apiURL = "https://keyauth.com/api/smitg0_14"  # <-- เปลี่ยนเป็น URL ของ KeyAuth คุณจริง ๆ
$appName = "Smithshop all"                    # <-- ชื่อ Application ใน KeyAuth
$secret = "d9b823207868f98f1cca7fb9c880047e525e05a1f998d6d07acc1862c207e2fc"                  # <-- Secret ของ Application
$exeUrl = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$exeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== CMDSMITHSHOP =====
Write-Host "=== MENU ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

switch ($choice) {
    "1" {
        $userKey = Read-Host "Enter your Key"

        # ตัวอย่างเชื่อม KeyAuth แบบง่าย
        # สำหรับตอนนี้ใช้ Key ที่คุณให้มาเป็นตัวตรวจสอบ
        $validKey = "devsmithshop"

        if ($userKey -eq $validKey) {
            Write-Host "✅ Key valid! Installing..."
            Invoke-WebRequest $exeUrl -OutFile $exeOutput
            Start-Process $exeOutput
            Write-Host "Installation complete ✅"
        } else {
            Write-Host "❌ Key invalid!" -ForegroundColor Red
        }
    }
    "2" {
        Write-Host "Cleaning..."
        if (Test-Path $exeOutput) {
            Remove-Item $exeOutput -Force
            Write-Host "File removed successfully ✅"
        } else {
            Write-Host "File not found ⚠️"
        }
    }
    default {
        Write-Host "Invalid choice ⚠️"
    }
}

Pause
