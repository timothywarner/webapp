
### Create & Apply Location Policy
{

$policyName = 'policyLocationDefinition'
$policyAssignment = 'policyLocationAssignment'
$policyFile = 'C:\pluralsight\policyLocation.json'

New-AzureRmPolicyDefinition `
    -Name $policyName `
    -Policy $policyFile `
    -Verbose

$resourceGroup = Get-AzureRmResourceGroup -Name 'unicorner-paas'
$policy = Get-AzureRmPolicyDefinition -Name $policyName

New-AzureRmPolicyAssignment `
    -Name $policyAssignment `
    -PolicyDefinition $policy `
    -Scope $resourceGroup.ResourceId `
    -Verbose

}