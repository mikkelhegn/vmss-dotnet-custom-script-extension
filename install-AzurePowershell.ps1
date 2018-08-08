$resourceGroup = "wincluster"
$vmssName = "default"

# Set the config
$fileUris = @("https://mikhegn.blob.core.windows.net/temp/install-dotnetcore.ps1")
$commandToExecute = 'powershell -NoProfile -ExecutionPolicy unrestricted -Command ./install-dotnetcore.ps1'
$settings = @{"fileUris" = $fileUris; "commandToExecute" = $commandToExecute}

# Get information about the scale set
$vmss = Get-AzureRmVmss -ResourceGroupName $resourceGroup -VMScaleSetName $vmssName

# Add the Custom Script Extension to install IIS and configure basic website
$vmss = Add-AzureRmVmssExtension `
  -VirtualMachineScaleSet $vmss `
  -Name "dotnetCoreInstallation" `
  -Publisher "Microsoft.Compute" `
  -Type "CustomScriptExtension" `
  -TypeHandlerVersion 1.9 `
  -AutoUpgradeMinorVersion $true
  -Setting $settings

# Update the scale set and apply the Custom Script Extension to the VM instances
Update-AzureRmVmss -ResourceGroupName $resourceGroup -Name $vmssName -VirtualMachineScaleSet $vmss