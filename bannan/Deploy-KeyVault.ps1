
### Define variables
{

$location = 'Australia Southeast'
$resourceGroupName = 'unicorner-keyvault'
$resourceDeploymentName = 'unicorner-vault'
$keyVaultName = 'unicorner-vault'
$password = 'Un1c0rn3R'
$parameterName = 'vmAdminPassword'

}

### Create Resource Group
{

New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $Location `
    -Verbose -Force

}

### Create KeyVault
{

New-AzureRmKeyVault `
    -VaultName $keyVaultName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -EnabledForTemplateDeployment

}

### Add Password to KeyVault
{

$adminPass = ConvertTo-SecureString `
    -String $password `
    -AsPlainText -Force

Set-AzureKeyVaultSecret `
    -VaultName $keyVaultName `
    -Name $parameterName `
    -SecretValue $adminPass

}

### Get Subscription ID
{

(Get-AzureRmSubscription).SubscriptionId

}