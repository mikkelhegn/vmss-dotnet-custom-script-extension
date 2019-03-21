Param(
  [string]$resourceGroup,
  [string]$vmssName
)

# Set the config
$fileUris = @("https://raw.githubusercontent.com/MikkelHegn/vmss-dotnet-custom-script-extension/master/Install-DotnetVMSS.ps1")
$commandToExecute = 'powershell -NoProfile -ExecutionPolicy unrestricted -Command ./install-dotnetcore.ps1'
$settings = @{"fileUris" = $fileUris; "commandToExecute" = $commandToExecute}

# Get information about the scale set
$vmss = Get-AzureRmVmss -ResourceGroupName $resourceGroup -VMScaleSetName $vmssName

$csExtension = $vmss.VirtualMachineProfile.ExtensionProfile.Extensions | where Type -eq CustomScriptExtension

if ($csExtension) {
  Write-Host "Error: CustomScriptExtension already in use on VMSS, remove before applying a new one." -ForegroundColor Red -BackgroundColor Black;
  $csExtension;
  break;
}

# Add the Custom Script Extension to install IIS and configure basic website
$vmss = Add-AzureRmVmssExtension `
  -VirtualMachineScaleSet $vmss `
  -Name "dotnetCoreInstallation" `
  -Publisher "Microsoft.Compute" `
  -Type "CustomScriptExtension" `
  -TypeHandlerVersion 1.9 `
  -AutoUpgradeMinorVersion $true `
  -ForceUpdateTag 1.0 `
  -Setting $settings

# Update the scale set and apply the Custom Script Extension to the VM instances
Update-AzureRmVmss -ResourceGroupName $resourceGroup -Name $vmssName -VirtualMachineScaleSet $vmss
