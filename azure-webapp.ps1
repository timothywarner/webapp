break
# #############################################################################
# Azure Web Apps
# AUTHOR:  Tim Warner
# EMAIL: timothy-warner@pluralsight.com
# TWITTER: @TechTrainerTim
# #############################################################################
 
# Press CTRL+M to expand/collapse regions

#region Obtain the Azure module
Find-Module -Name AzureRM.Websites -AllVersions

Install-Module -Name AzureRM -MaximumVersion -Verbose

Update-Help -Force
#endregion

#region Connect to Azure
Set-Location -Path 'C:\Users\Tim\Dropbox\PowerShell Summit 2017'
Login-AzureRmAccount
Get-AzureRmContext   # Get-AzureRmSubscription
Set-AzureRmContext -SubscriptionName ''
Save-AzureRmProfile -Path '.\profile.json'
Select-AzureRmProfile -Path '.\profile.json'
#endregion

#region Discovery
Get-Command -Module AzureRM.Websites | Select-Object -Property Name | Sort-Object -Property Name | Format-Wide -Column 2
 
Get-Help -Name New-AzureRmAppServicePlan -ShowWindow
Get-Help -Name New-AzureRmAppServicePlan -Online
Start-Process https://docs.microsoft.com/en-us/powershell/module/azurerm.websites/new-azurermappserviceplan?view=azurermps-2.2.0
#endregion

#region App Service Plans
New-AzureRmResourceGroup -Name 'pssummit2017' -Location 'West US' 
$rg = Get-AzureRmResourceGroup -Name 'pssummit2017'
$asp = 'pssummitplan'

New-AzureRmAppServicePlan -Name $asp -Location 'West US' -ResourceGroupName 'pssummit2017' -Tier Free -Verbose

Get-AzureRmAppServicePlan -Name $asp | Format-List *

Get-AzureRmAppServicePlan | Get-Member

Set-AzureRmAppServicePlan -Name $asp -ResourceGroupName 'pssummit2017' -Tier Standard

Remove-AzureRmAppServicePlan -Name $asp -ResourceGroupName 'pssummit2017'

#endregion

#region Create a Web App

$appName = 'pssummitwebapp101'

New-AzureRmWebApp -Name $appName -AppServicePlan $asp `
-ResourceGroupName 'pssummit2017' -Location 'WestUS'

Remove-AzureRmWebApp -Name $appName -ResourceGroupName 'pssummit2017'

Get-AzureRmWebApp -ResourceGroupname 'pssummit2017'

#endregion

#region Modify Web App Settings

$connectionstrings = @{ ITEdgeConn1 = @{ Type = 'MySql'; Value = 'MySqlConn'}; ITEdgeConn2 = @{ Type = 'SQLAzure'; Value = 'SQLAzureConn'} }
Set-AzureRmWebApp -Name $appName -ResourceGroupName 'pssummit2017' -ConnectionStrings $connectionstrings

$appsettings = @{appsetting1 = "appsetting1value"; appsetting2 = "appsetting2value"}

Set-AzureRmWebApp -Name $appName -ResourceGroupName 'pssummit2017' -AppSettings $appsettings

Set-AzureRmWebApp -Name $appName -ResourceGroupName 'pssummit2017' -Use32BitWorkerProcess $False

#endregion

#region Web App Run States

Restart-AzureRmWebapp -Name $appName -ResourceGroupName 'pssummit2017'

Stop-AzureRmWebapp -Name $appName -ResourceGroupName 'pssummit2017'

Start-AzureRmWebapp -Name $appName -ResourceGroupName 'pssummit2017'

Get-AzureRmWebAppPublishingProfile -Name $appName -ResourceGroupName 'pssummit2017' -OutputFile 'c:\profile.xml'

ise 'C:\profile.xml'

#endregion

#region ARM Template Deployment

Set-Location -Path 'D:\Dropbox (Personal)\PowerShell Summit 2017\tues-Azure-Web-Apps\webapp\simplewebapp'

# show in VS 2017
ise ./azuredeploy.json

ise ./azuredeploy.parameters.json

New-AzureRmResourceGroupDeployment -Name 'Webapp2GitHub' -ResourceGroupName 'pssummit2017' `
# -TemplateUri '' `
-TemplateFile '.\azuredeploy.json' `
-TemplateParameterFile '.\azuredeploy.parameters.json' `
# -TemplateParameterUri '' `
-Mode Complete

#endregion
