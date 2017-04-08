### Define variables
{
$location = 'Australia Southeast'
$resourceGroupName = 'pluralsight-arm-simple-iaas-template'
$resourceDeploymentName = 'pluralsight-arm-iaas-template-deployment'
$templatePath = $env:SystemDrive + '\pluralsight'
$templateFile = 'simpleIaas.json'
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