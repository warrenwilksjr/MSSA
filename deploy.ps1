Login-AzAccount
 
Get-AzSubscription
 
Select-AzSubscription -Subscription "Visual Studio Enterprise"
 
$ARMParams = @{
    Mode        = 'incremental'
    templateFile = 'C:\Users\warwi\OneDrive\Documents\MSSA\AzureDeploy.json'
    ResourceGroupName = 'mssaproj'
    Verbose     = $true
}
Test-AzResourceGroupDeployment @ARMParams
New-AzResourceGroupDeployment @ARMParams