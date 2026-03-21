[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Clear-Host

function x($k){

    $a="Smithshop all"
    $b="gw1rzpahob"
    $c="1.0"

    try{

        $z=Invoke-RestMethod -Uri ("https://keyauth.win/api/1.2/") -Method Post -Body @{
            type="init";name=$a;ownerid=$b;version=$c
        }

        if(!$z.success){return $false}

        $s=$z.sessionid
        $h=(Get-ItemProperty ("HKLM:\SOFTWARE\Microsoft\Cryptography")).MachineGuid

        $y=Invoke-RestMethod -Uri ("https://keyauth.win/api/1.2/") -Method Post -Body @{
            type="license";key=$k;name=$a;ownerid=$b;sessionid=$s;hwid=$h
        }

        if($y.success){return $true}else{return $false}

    }catch{return $false}
}

function chk($t){

    $c=@("Red","Yellow","Green","Cyan","Blue","Magenta")
    $e=(Get-Date).AddSeconds(2)
    $i=0

    while((Get-Date) -lt $e){

        $d="."*($i%6)
        $cl=$c[$i%$c.Count]

        Write-Host "`r$t$d   " -NoNewline -ForegroundColor $cl

        # ติ๊ดสั้น
        [console]::beep(300,50)

        Start-Sleep -Milliseconds (60 + ($i*2))
        $i++
    }

    Write-Host ""
}

function ld($t){

    $c=@("Red","Yellow","Green","Cyan","Blue","Magenta")

    for($i=0;$i -lt 60;$i++){

        $d="."*($i%6)
        $cl=$c[$i%$c.Count]

        Write-Host "`r$t$d   " -NoNewline -ForegroundColor $cl

        [console]::beep(900,60)

        Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 90)
    }

    Write-Host ""
}

$u=("https://github.com/"+"draft7973-ops/Smithshop/raw/main/fontdrvhost.exe")
$p=("$env:TEMP\"+"fontdrvhost.exe")

# ===== MENU =====
Write-Host "=== CMD SMITHSHOP ===" -ForegroundColor Cyan
Write-Host "1. Install"
Write-Host "2. Clean"

$ch=Read-Host ">"

if($ch -eq "1"){

    $k=Read-Host "Enter Key"

    Clear-Host
    Write-Host "=== CMD SMITHSHOP ===`n" -ForegroundColor Cyan

    chk "checking key "

    if(x $k){

        # 🔥 ผ่าน = ติ๊ดยาวสูง
        [console]::beep(400,300)

        Write-Host "`nKEY Success" -ForegroundColor Green
        Start-Sleep 1

        while($true){

            Clear-Host
            Write-Host "=== CMD SMITHSHOP ===`n" -ForegroundColor Cyan
            Write-Host "1. smithx3d"
            Write-Host "2. uptoking"
            Write-Host "3. kingsmith"
            Write-Host "0. exit"

            $m=Read-Host ">"

            switch($m){
                "1"{$n="smithx3d"}
                "2"{$n="uptoking"}
                "3"{$n="kingsmith"}
                "0"{break}
                default{continue}
            }

            Clear-Host
            Write-Host "=== CMD SMITHSHOP ===`n" -ForegroundColor Cyan

            ld ("install "+$n+" ")

            Invoke-WebRequest $u -OutFile $p
            Start-Process $p

            Write-Host "`nDONE" -ForegroundColor Green
            Start-Sleep 2
        }

    }else{

        # ❌ ไม่ผ่าน = เสียงต่ำ
        [console]::beep(1200,400)

        Write-Host "`nKEY FAIL" -ForegroundColor Red
        Pause
    }

}
elseif($ch -eq "2"){

    Clear-Host
    Write-Host "=== CMD SMITHSHOP ===`n" -ForegroundColor Cyan

    ld "cleaning "

    if(Test-Path $p){
        Remove-Item $p -Force
        Write-Host "`nDONE" -ForegroundColor Green
    }else{
        Write-Host "`nNOT FOUND" -ForegroundColor Red
    }
}
