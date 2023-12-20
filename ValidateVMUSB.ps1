#VmUUID=VBoxManage list --long vms
#USBUUIDS=VBoxManage list usbhost
#PowerShell -Command "C:\PersonalProjects\HomeAssistant\ValidateVMUSB.ps1;"

$MachineHPE=@{	VmUUID		="f5dd7d3f-399e-427d-99b7-5f7fe321bbae";
				USBUUIDS	= @("2c0a749d-b30a-431a-a01d-f0fa85dc7fe2")}

$Machine=	@{	VmUUID		="f05c746c-a545-4329-8252-bc3b42907131";
				USBUUIDS	= @("6f06b710-ee69-4e5d-917b-d0808827102c","93cedeaf-a6f8-49c2-ab9e-0192aa434ba2")}

$Constants = @{	VBoxManage	= "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe";
				UUIDString	="UUID:";
				StateString	="State:";
				Sleep		="5"}

$MyArgs = "list", "--long", "vms"
Write-Host $Constants.VBoxManage $MyArgs
$Status="Starting"
& $Constants.VBoxManage $MyArgs | ForEach-Object {
	if ($_.Contains($Constants.UUIDString) -and $_.Contains($Machine.UUID) -and ($Status -eq "Starting")) {
		Write-Host "UUID="$_.split(":")[1].Trim()
		$Status="UUIDDetected"
	}
	if ($_.Contains($Constants.StateString) -and ($Status -eq "UUIDDetected")) {
		Write-Host "State="$_.split(":")[1].Trim()
		$Status="StateDetected"
		if($_.split(":")[1].Trim().Contains("paused")){
			$MyArgs = "controlvm", $Machine.VmUUID, "resume"
			Write-Host $Constants.VBoxManage $MyArgs
			& $Constants.VBoxManage $MyArgs
		}
		if($_.split(":")[1].Trim().Contains("powered off")){
			$MyArgs = "startvm", $Machine.VmUUID, "--type=headless"
			Write-Host $Constants.VBoxManage $MyArgs
			& $Constants.VBoxManage $MyArgs
		}
		if($_.split(":")[1].Trim().Contains("running")){
			Write-Host "OK"
		}
	}
}

$NeedToReload=0
foreach ($USBUUID in $Machine.USBUUIDS)
{
	$MyArgs = "list", "usbhost"
	Write-Host $Constants.VBoxManage $MyArgs
	$Status="Starting"
	& $Constants.VBoxManage $MyArgs | ForEach-Object {
		if ($_.Contains($Constants.UUIDString) -and $_.Contains($USBUUID) -and ($Status -eq "Starting")) {
			Write-Host "USBUUID="$_.split(":")[1].Trim()
			$Status="USBUUIDDetected"
		}
		if ($_.Contains($Constants.StateString) -and ($Status -eq "USBUUIDDetected")) {
			$Status="Starting"
			if (-not $_.split(":")[1].Trim().contains("Captured")){
				$MyArgs = "controlvm", $Machine.VmUUID, "usbattach", $USBUUID
				Write-Host $Constants.VBoxManage $MyArgs
				& $Constants.VBoxManage $MyArgs
				$NeedToReload=1
			}else{
				Write-Host "USBState="$_.split(":")[1].Trim()
			}
		}
	}
}

if($NeedToReload -eq 1){
	for ($Num = 1 ; $Num -le $Constants.Sleep ; $Num++){
		$MyArgs = "controlvm", $Machine.VmUUID, "keyboardputscancode", "1C", "9C"
		Write-Host $Constants.VBoxManage $MyArgs
		& $Constants.VBoxManage $MyArgs
		Start-Sleep -Seconds 1
	}

	$MyArgs = "controlvm", $Machine.VmUUID, "keyboardputstring", "network reload"
	Write-Host $Constants.VBoxManage $MyArgs
	& $Constants.VBoxManage $MyArgs

	$MyArgs = "controlvm", $Machine.VmUUID, "keyboardputscancode", "1C", "9C"
	Write-Host $Constants.VBoxManage $MyArgs
	& $Constants.VBoxManage $MyArgs
}
