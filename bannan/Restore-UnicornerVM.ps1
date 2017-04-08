
### Define Variables
{

$resourceGroupName = 'unicorner-iaas'
$vmVirtualNetwork = 'unicorner-vnet-azure'
$vmName = 'vmWeb-1'
$vmStorageName = 'unicorner1'
$vmAvailabilitySetName = 'as-vmWeb'

}

### Select VM to restore
{

$namedContainer = Get-AzureRmRecoveryServicesBackupContainer `
    -ContainerType AzureVM `
    –Status Registered `
    -Name $vmName

$backupitem = Get-AzureRmRecoveryServicesBackupItem `
    –Container $namedContainer `
    –WorkloadType AzureVM `
    -Name $vmName

}

### Choose a Recovery Point
{

$startDate = (Get-Date).AddDays(-7)

$endDate = Get-Date

$rp = Get-AzureRmRecoveryServicesBackupRecoveryPoint `
    -Item $backupitem `
    -StartDate $startdate.ToUniversalTime() `
    -EndDate $enddate.ToUniversalTime()

$rp[0]

}

### Restore the Disks
{

Restore-AzureRmRecoveryServicesBackupItem `
    -RecoveryPoint $rp[0] `
    -StorageAccountName $vmStorageName `
    -StorageAccountResourceGroupName $resourceGroupName

$restorejob = (Get-AzureRmRecoveryServicesBackupJob)[0]

}

### Get Details of Restore Operation
{

$details = Get-AzureRmRecoveryServicesBackupJobDetails -JobId $restorejob.JobId

}

### Create a VM from Restored Disks
{

$properties = $details.properties
$storageAccountName = $properties["Target Storage Account Name"]
$containerName = $properties["Config Blob Container Name"]
$blobName = $properties["Config Blob Name"]

}
{

Set-AzureRmCurrentStorageAccount `
    -Name $storageaccountname `
    -ResourceGroupName $resourceGroupName

$destination_path = 'C:\pluralsight\vmconfig.json'

Get-AzureStorageBlobContent `
    -Container $containerName `
    -Blob $blobName `
    -Destination $destination_path

$obj = ((Get-Content `
    -Path $destination_path `
    -Encoding Unicode)).TrimEnd([char]0x00) | `
    ConvertFrom-Json

}
{

$availabilitySetID = (Get-AzureRmAvailabilitySet `
    -Name $vmAvailabilitySetName `
    -ResourceGroupName $resourceGroupName).Id

}
{

$vm = New-AzureRmVMConfig `
    -VMSize $obj.HardwareProfile.VirtualMachineSize `
    -VMName $vmName `
    -AvailabilitySetId $availabilitySetID

}
{

$vmOSDiskName = $vmName + '-' + 'osDisk'

Set-AzureRmVMOSDisk `
    -VM $vm `
    -Name $vmOSDiskName `
    -VhdUri $obj.StorageProfile.OSDisk.VirtualHardDisk.Uri `
    -CreateOption Attach

$vm.StorageProfile.OsDisk.OsType = $obj.StorageProfile.OSDisk.OperatingSystemType

}
{

$nicName = $vmName + '-' + 'nic-0'

$vnet = Get-AzureRmVirtualNetwork `
    -Name $vmVirtualNetwork `
    -ResourceGroupName $resourceGroupName

$nic = Get-AzureRmNetworkInterface `
    -Name $nicName `
    -ResourceGroupName $resourceGroupName

$vm = Add-AzureRmVMNetworkInterface `
    -VM $vm `
    -Id $nic.Id

}
{

New-AzureRmVM `
    -ResourceGroupName $resourceGroupName `
    -Location (Get-AzureRmResourceGroup -Name $resourceGroupName).Location `
    -VM $vm -Verbose

}