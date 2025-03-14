# Check if Acrobat Reader or Acrobat (Standard/Pro) is installed and change the values based on the version installed.

$checkADCversion = Get-ItemProperty -Path "HKLM:\SOFTWARE\Adobe\Adobe Acrobat\DC\Installer" | Select-Object -ExpandProperty "SCAPackageLevel"
If ($checkADCversion -eq 1){
    $Path = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
    $Name = "bEnableFlash"
    $Type = "DWORD"
    $Value = 0
    New-ItemProperty -Path $Path -Name $Name -PropertyType $Type -Value $Value -Force -ea SilentlyContinue;
}
Else {
    $Path = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
    $Name = "bEnableFlash"
    $Type = "DWORD"
    $Value = 0
    New-ItemProperty -Path $Path -Name $Name -PropertyType $Type -Value $Value -Force -ea SilentlyContinue;
}
