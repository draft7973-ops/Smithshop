function x($k){

    $a="Smithshop all"
    $b="gw1rzpahob"
    $c="1.0"

    try{

        $z=Invoke-RestMethod -Uri ("https://keyauth.win/api/1.2/") -Method Post -Body @{
            type="init";name=$a;ownerid=$b;version=$c
        }

        if(!$z.success){return "error"}

        $s=$z.sessionid
        $h=(Get-ItemProperty ("HKLM:\SOFTWARE\Microsoft\Cryptography")).MachineGuid

        $y=Invoke-RestMethod -Uri ("https://keyauth.win/api/1.2/") -Method Post -Body @{
            type="license";key=$k;name=$a;ownerid=$b;sessionid=$s;hwid=$h
        }

        if($y.success){
            return "ok"
        }else{

            if($y.message -like "*hwid*"){
                return "used"
            }

            return "fail"
        }

    }catch{
        return "error"
    }
}
