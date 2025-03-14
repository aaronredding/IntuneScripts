# Detect if Acrobat is even installed
# Need to add detection if 32-bit is installed and modify code accordingly (if needed)

Try {
  $checkADCreg = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.DisplayName -like "Adobe Acrobat*"}
  If ($CheckADCReg -eq $null) {
    Write-Warning "Acrobat NOT Installed"
    Exit 0
  } 
	else {
    # Check which version is installed (Acrobat Reader DC or Acrobat Standard/Pro DC) this is done by detecting the Package Level flag in the registry.
    # SCAPackageLevel: 1 = Acrobat Reader, 2 = ??, 3 = ??, 4 = Acrobat Pro
    # Current version of this script detects if Acrobat Reader is installed, if it isn't then assumed is Acrobat DC (Standard/Pro) and puts the registry entry accordingly
	  $checkADCversion = Get-ItemProperty -Path "HKLM:\SOFTWARE\Adobe\Adobe Acrobat\DC\Installer" | Select-Object -ExpandProperty "SCAPackageLevel"
		If ($checkADCversion -eq 1){
			$Path = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
			$Name = "bEnableFlash"
			$Type = "DWORD"
			$Value = 0
		}
		Else {
			$Path = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
			$Name = "bEnableFlash"
			$Type = "DWORD"
			$Value = 0
		}
		Try {
			$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
			If ($Registry -eq $Value){
				Write-Output "Registry entry PRESENT"
				Exit 0
			} 
			Write-Warning "Registry entry NOT PRESENT"
			Exit 1
		}
		Catch {
			Write-Warning "An ERROR occured"
			Exit 1
		}
	}
}
Catch {
	Write-Warning "Acrobat NOT installed"
	Exit 1
}
