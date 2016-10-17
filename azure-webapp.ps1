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

Get-Command -Module AzureRM.Websites | Select-Object -Property Name | Format-Wide -Column 2

Get-Command -Module Azure | Where-Object { $_.Name -like "*website*"} | Select-Object -Property Name | Format-Wide -Column 2

Get-Help -Name New-AzureRmWebApp -ShowWindow

Get-Help -Name New-AzureWebsite -ShowWindow

#endregion










