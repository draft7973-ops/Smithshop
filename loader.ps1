[Console]::OutputEncoding = [Text.Encoding]::UTF8
Add-Type -AssemblyName System.Windows.Forms

$global:AppPath = ""

function chk($t){
    $c = @("Red","Yellow","Green","Cyan","Blue","Magenta")
    for($i = 0; $i -lt 20; $i++){
        $d  = "." * ($i % 6)
        $cl = $c[$i % $c.Count]
        Write-Host ("`r" + $t + $d + "   ") -NoNewline -ForegroundColor $cl
        Start-Sleep -Milliseconds 80
    }
    Write-Host ""
}

function Select-App {
    $dlg = New-Object System.Windows.Forms.OpenFileDialog
    $dlg.Title = "Select EXE file"
    $dlg.Filter = "Executable (*.exe)|*.exe|All files (*.*)|*.*"

    if($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){
        $global:AppPath = $dlg.FileName
        Write-Host "`nSelected:" -ForegroundColor Green
        Write-Host $global:AppPath -ForegroundColor Cyan
    }
    else{
        Write-Host "`nNo file selected" -ForegroundColor Yellow
    }

    Pause
}

function Run-App {
    if([string]::IsNullOrWhiteSpace($global:AppPath)){
        Write-Host "`nNo file selected yet" -ForegroundColor Red
        Pause
        return
    }

    if(-not (Test-Path $global:AppPath)){
        Write-Host "`nFile not found" -ForegroundColor Red
        Pause
        return
    }

    chk "running "
    Start-Process $global:AppPath
    Write-Host "`nStarted:" -ForegroundColor Green
    Write-Host $global:AppPath -ForegroundColor Cyan
    Pause
}

function Check-App {
    if([string]::IsNullOrWhiteSpace($global:AppPath)){
        Write-Host "`nNo file selected yet" -ForegroundColor Yellow
    }
    elseif(Test-Path $global:AppPath){
        Write-Host "`nFile ready" -ForegroundColor Green
        Write-Host $global:AppPath -ForegroundColor Cyan
    }
    else{
        Write-Host "`nSaved path no longer exists" -ForegroundColor Red
    }

    Pause
}

while($true){
    cls
    Write-Host "=== MENU ===`n" -ForegroundColor Cyan
    Write-Host "1. Run selected EXE"
    Write-Host "2. Select EXE"
    Write-Host "3. Check selected path"
    Write-Host "0. Exit"

    if(-not [string]::IsNullOrWhiteSpace($global:AppPath)){
        Write-Host "`nCurrent: $global:AppPath" -ForegroundColor DarkGray
    }

    $m = Read-Host ">"

    switch($m){
        "1" { Run-App }
        "2" { Select-App }
        "3" { Check-App }
        "0" { break }
        default { continue }
    }
}
