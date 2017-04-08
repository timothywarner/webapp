### Define variables
{
$location = 'Australia Southeast'
$resourceGroupName = 'pluralsight-arm-simple-paas-template'
$resourceDeploymentName = 'pluralsight-arm-paas-template-deployment'
$templatePath = $env:SystemDrive + '\pluralsight'
$templateFile = 'simplePaas.json'
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