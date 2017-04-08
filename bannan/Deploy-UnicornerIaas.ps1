### Define variables
{
$location = 'Australia Southeast'
$resourceGroupName = 'unicorner-iaas'
$resourceDeploymentName = 'unicorner-iaas-deployment'
$templatePath = $env:SystemDrive + '\pluralsight'
$templateFile = 'unicornerIaas.json'
$template = $templatePath + '\' + $templateFile
$password = "Un1c0rn3R"
$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
}

### Create Resource Group
{
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $Location `
    -Verbose -Force
}

### Deploy Resources
{

$additionalParameters = New-Object -TypeName Hashtable
$additionalParameters['vmAdminPassword'] = $securePassword

New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
    @additionalParameters `
    -Verbose -Force
}