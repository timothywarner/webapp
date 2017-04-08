### Define variables
{
$resourceGroupLocation = 'Australia Southeast'
$resourceGroupName = 'unicorner-paas'
$resourceDeploymentName = 'unicorner-paas-deployment'
$templatePath = $env:SystemDrive + '\pluralsight'
$templateFile = 'unicornerPaas.json'
$template = $templatePath + '\' + $templateFile
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
New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
    -Verbose -Force
}