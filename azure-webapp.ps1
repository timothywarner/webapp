break
# #############################################################################
# Azure Web Apps
# AUTHOR:  Tim Warner
# EMAIL: timothy-warner@pluralsight.com
# TWITTER: @TechTrainerTim
# #############################################################################
 
# Press CTRL+M to expand/collapse regions

#region Connect to Azure

$defaultSubscription = '150dollar'
$defaultStorageAccount = 'itedgestorage'
$defaultResourceGroup = 'ITEdgeRG'

Login-AzureRmAccount -SubscriptionName $defaultSubscription
Select-AzureRmSubscription -SubscriptionName $defaultSubscription
Set-AzureRmCurrentStorageAccount -ResourceGroupName $defaultResourceGroup -StorageAccountName $defaultStorageAccount 
Set-AzureRmContext -SubscriptionName $defaultSubscription

#endregion

#region Housekeeping

$PSVersionTable

Set-ExecutionPolicy -ExecutionPolicy Bypass -Force -Scope Process

Update-Help -Force -ErrorAction SilentlyContinue

#endregion

#region Discovery

Get-Command -Module AzureRM.Websites | Select-Object -Property Name | Format-Wide -Column 2

Get-Command -Module Azure | Where-Object { $_.Name -like "*website*"} | Select-Object -Property Name | Format-Wide -Column 2

Get-Help -Name New-AzureRmWebApp -ShowWindow

Get-Help -Name New-AzureWebsite -ShowWindow

#endregion

#region App Service Plans

New-AzureRmAppServicePlan -Name itedgeserviceplan2 -Location "South Central US" -ResourceGroupName $defaultResourceGroup -Tier Premium -WorkerSize Large -NumberofWorkers 10

New-AzureRmAppServicePlan -Name itedgeserviceplan2 -Location "South Central US" -ResourceGroupName $defaultResourceGroup -AseName constosoASE -AseResourceGroupName contosoASERG -Tier Premium -WorkerSize Large -NumberofWorkers 10

Get-AzureRmAppServicePlan -ResourceGroupname $defaultResourceGroup

Get-AzureRmAppServicePlan -Name itedgeserviceplan2

Set-AzureRmAppServicePlan -Name itedgeserviceplan2 -ResourceGroupName $defaultResourceGroup -Tier Standard -WorkerSize Medium -NumberofWorkers 9

Set-AzureRmAppServicePlan -Name itedgeserviceplan2 -ResourceGroupName $defaultResourceGroup -NumberofWorkers 9

Set-AzureRmAppServicePlan -Name itedgeserviceplan2 -ResourceGroupName $defaultResourceGroup -Tier Standard

Remove-AzureRmAppServicePlan -Name itedgeserviceplan2 -ResourceGroupName $defaultResourceGroup

#endregion

#region Create a Web App

New-AzureRmWebApp -Name ITEdgeWebApp100 -AppServicePlan itedgeserviceplan2 -ResourceGroupName $defaultResourceGroup -Location "South Central US"

New-AzureRmWebApp -Name ITEdgeWebApp100 -AppServicePlan itedgeserviceplan2 -ResourceGroupName $defaultResourceGroup -Location "South Central US"  -ASEName ContosoASEName -ASEResourceGroupName ContosoASEResourceGroupName

Remove-AzureRmWebApp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup

Get-AzureRmWebApp

Get-AzureRmWebApp -ResourceGroupname $defaultResourceGroup



#endregion

#region Modify Web App Settings

$connectionstrings = @{ ContosoConn1 = @{ Type = “MySql”; Value = “MySqlConn”}; ContosoConn2 = @{ Type = “SQLAzure”; Value = “SQLAzureConn”} }
Set-AzureRmWebApp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup -ConnectionStrings $connectionstrings

$appsettings = @{appsetting1 = "appsetting1value"; appsetting2 = "appsetting2value"}
Set-AzureRmWebApp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup -AppSettings $appsettings

Set-AzureRmWebApp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup -Use32BitWorkerProcess $False

#endregion

#region Web App Run States

Restart-AzureRmWebapp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup

Stop-AzureRmWebapp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup

Start-AzureRmWebapp -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup

Get-AzureRmWebAppPublishingProfile -Name ITEdgeWebApp100 -ResourceGroupName $defaultResourceGroup -OutputFile .\publishingprofile.txt

#endregion

#region ARM Template Deployment

ise ./azuredeploy.json

ise ./azuredeploy.parameters.json

New-AzureRmResourceGroupDeployment -Name 'Webapp2GitHub' -ResourceGroupName $defaultResourceGroup `
-TemplateUri '' `
-TemplateFile '' `
-TemplateParameterFile `
-TemplateParameterUri '' `
-Mode Complete/Incremental

#endregion
