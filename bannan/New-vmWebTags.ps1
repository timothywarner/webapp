
### Get vmWeb VMs
{

$VMs = Get-AzureRmResource | `
    Where-Object {$_.Name -like "vmWeb-*" -and $_.ResourceType -like 'Microsoft.Compute/virtualMachines'}

}

### Add Tags to Resources
{

foreach($VM in $VMs){
    Set-AzureRmResource `
        -Tag @( `
            @{ Name="department"; Value="IT" }, `
            @{ Name="environmemt"; Value="Production"} `
            ) `
        -ResourceId $VM.ResourceId
    }
}