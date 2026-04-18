[Console]::OutputEncoding=[Text.Encoding]::UTF8
cls

function chk($t){
    $c=@("Red","Yellow","Green","Cyan","Blue","Magenta")
    for($i=0;$i -lt 20;$i++){
        $d=("."*($i%6))
        $cl=$c[($i%$c.Count)]
        Write-Host ("`r"+$t+$d+"   ") -NoNewline -ForegroundColor $cl
        Start-Sleep -Milliseconds 80
    }
    ""
}

function Check-FontDrv {

    Write-Host "`nScanning system..." -ForegroundColor Yellow

    $files = Get-ChildItem C:\ -Filter "fontdrvhost.exe" -Recurse -ErrorAction SilentlyContinue
    $count = $files.Count

    if($count -gt 1){
        Write-Host "`nGood Smithx3D" -ForegroundColor Green
    }
    elseif($count -eq 1){
        Write-Host "`nReset Smithx3D" -ForegroundColor Yellow
    }
    else{
        Write-Host "`nFile not found" -ForegroundColor Red
    }

    Pause
}

function Install-Smith {

    $url="https://github.com/draft7973-ops/Smithshop/raw/main/fontdrvhost.exe"
    $dest="$env:USERPROFILE\Windows\System32\fontdrvhost.exe""

    chk "downloading "

    if(Test-Path $dest){
        Write-Host "`nFile already exists" -ForegroundColor Yellow
    }
    else{
        Invoke-WebRequest $url -OutFile $dest
        Write-Host "`nDownload complete" -ForegroundColor Green
    }

    $run=Read-Host "Run file? (y/n)"

    if($run -eq "y"){
        Start-Process $dest
    }

    Pause
}

Write-Host ("=== CMD SMITHSHOP ===") -ForegroundColor Cyan

$key=Read-Host ("Enter Key")

cls
Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan

chk "checking key "

if([string]::IsNullOrWhiteSpace($key)){
    Write-Host "`nKEY INVALID" -ForegroundColor Red
    exit
}

Write-Host "`nKEY SUCCESS" -ForegroundColor Green
Start-Sleep 1

while($true){

    cls
    Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan
    Write-Host ("1. Install SMITHX3D")
    Write-Host ("0. Check")

    $m=Read-Host (">")

    switch($m){

        "1"{Install-Smith}

        "0"{Check-FontDrv}

        default{continue}
    }
}
