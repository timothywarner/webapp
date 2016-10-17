break
# #############################################################################
# Azure CLI
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

#region Navigating the Azure CLI

Start-Process https://github.com/Azure/azure-xplat-cli

azure

azure help login

azure login

Start-Process https://aka.ms/devicelogin

azure config mode arm

azure account list

azure account show '150dollar'

azure account set '150dollar'

azure help webapp

azure webapp list 'ITEdgeRG'

azure location list

azure help webapp create

azure webapp create -v -g 'ITEdgeRG' -n 'itedgetest01' -l 'westus' -p 'itedgeSP'

azure webapp list 'ITEdgeRG'

azure webapp show -n 'itedgetest01' -g 'ITEdgeRG'

azure webapp stop/start/restart/delete -n 'itedgetest01' -g 'ITEdgeRG'

#endregion

#region App Settings

azure config mode asm

azure

azure help site

azure site list

azure site appsetting list 'itedgetest01'

#endregion

#region ARM template deployment

Start-Process https://azure.microsoft.com/en-us/documentation/templates/201-web-app-github-deploy/

Start-Process https://github.com/Azure/azure-quickstart-templates/tree/master/201-web-app-github-deploy

azure group deployment create --template-uri https://github.com/timothywarner/webapp/simplewebapp/azuredeploy.json -g 'ITEdgeRG' -n 'itedgeCLIdeploy01' 

#endregion





