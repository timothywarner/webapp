break
# #############################################################################
# Azure Web App Pod
# AUTHOR:  Tim Warner
# EMAIL: timothy-warner@pluralsight.com
# TWITTER: @TechTrainerTim
# #############################################################################
 
# Press CTRL+M to expand/collapse regions

#region Connect to Azure

Set-Location -Path 'C:\Users\Tim\Dropbox\path-to-repo\'
Login-AzureRmAccount
Get-AzureRmContext   # Get-AzureRmSubscription
Set-AzureRmContext -SubscriptionName ''

Save-AzureRmProfile -Path '.\profile.json'
Select-AzureRmProfile -Path '.\profile.json'
#endregion

#region ARM Template Deployment

Set-Location -Path 'D:\Dropbox (Personal)\PowerShell Summit 2017\webapp\apppod'

# show in VS 2017
ise ./azuredeploy.json

ise ./azuredeploy.parameters.json

New-AzureRmResourceGroup -Name 'pssummit20172' -Location 'Central US' 
New-AzureRmResourceGroupDeployment -Name 'PSSummitDeployment2' -ResourceGroupName 'pssummit20172' -TemplateFile '.\azuredeploy.json' -TemplateParameterFile '.\azuredeploy.parameters.json' -Mode Complete -Verbose

#endregion
