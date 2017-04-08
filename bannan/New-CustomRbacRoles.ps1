
### Get Azure Subscription ID
{

$subscriptionID = (Get-AzureRmSubscription).SubscriptionId

}


### Create New RBAC Role
{

$role = Get-AzureRmRoleDefinition -Name 'Virtual Machine Contributor'

$role.Id = $null
$role.Name = 'Virtual Machine Operator'
$role.IsCustom = 'True'
$role.Description = 'Can monitor, start, and restart virtual machines.'
$role.Actions.RemoveRange(0,$role.Actions.Count)
$role.Actions.Add('Microsoft.Compute/*/read')
$role.Actions.Add('Microsoft.Compute/virtualMachines/start/action')
$role.Actions.Add('Microsoft.Compute/virtualMachines/restart/action')
$role.Actions.Add('Microsoft.Network/*/read')
$role.Actions.Add('Microsoft.Storage/*/read')
$role.Actions.Add('Microsoft.Authorization/*/read')
$role.Actions.Add('Microsoft.Resources/subscriptions/resourceGroups/read')
$role.Actions.Add('Microsoft.Resources/subscriptions/resourceGroups/resources/read')
$role.Actions.Add('Microsoft.Insights/alertRules/*')
$role.Actions.Add('Microsoft.Support/*')
$role.AssignableScopes.Remove('/') | Out-Null
$role.AssignableScopes.Add("/subscriptions/$subscriptionID")

    
New-AzureRmRoleDefinition -Role $role 

}

### Assign Role to Group
{

$adGroups = Get-AzureRmADGroup -SearchString 'VM Operators'

New-AzureRmRoleAssignment `
    -ObjectId $adGroups[0].Id.Guid `
    -RoleDefinitionName 'Virtual Machine Operator' `
    -Scope "/subscriptions/$subscriptionID"

}