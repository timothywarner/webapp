
$recoveryVaultName = 'pluralsight-vault'
$recoveryVaultRGName = 'pluralsight-recovery-services'
$recoveryVaultLocation = 'Australia Southeast'

### Create Resource Group
New-AzureRmResourceGroup `
    -Name $recoveryVaultRGName `
    -Location $recoveryVaultLocation `
    -Verbose

### Create Recovery Services Vault
New-AzureRmRecoveryServicesVault `
    -Name $recoveryVaultName `
    -ResourceGroupName $recoveryVaultRGName `
    -Location $recoveryVaultLocation `
    -Verbose

### Connect to Recovery Services Vault
$recoveryVault = Get-AzureRmRecoveryServicesVault `
    -ResourceGroupName $recoveryVaultRGName `
    -Name $recoveryVaultName

Set-AzureRmRecoveryServicesVaultContext -Vault $recoveryVault