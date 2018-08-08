# VMSS Custom Script Extension for dotnet core

This repo contains the json configuration and commands to update your Azure Virtual Machine Scale Set model to have dotnet core runtime installed.

Using VMSS custom script extensions and the dotnet-install script: Built using this script https://github.com/dotnet/docs/blob/master/docs/core/tools/dotnet-install-script.md

## How to use the extension

1. Change the dotnetcore.json file with the parameters for the script which matches the version of dotnet core you need on your cluster together with other install options. Use this for reference: https://github.com/dotnet/docs/blob/master/docs/core/tools/dotnet-install-script.md

1. Choose how to change the VMSS model (PowerShell, ARM deployment or Azure CLI). You can follow the guidance in either of the following links:
    - ARM: https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/tutorial-install-apps-template
    - PowerShell: https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/tutorial-install-apps-powershell
    - AzureCLI: https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/tutorial-install-apps-cli

1. Validate the installation of the script by ...

## Troubleshooting

- dotnet core requirements: https://docs.microsoft.com/en-us/dotnet/core/windows-prerequisites?tabs=netcore2x
- VMSS extension FAQ: https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-faq#extensions

## Issues

- Cannot use dotnet.exe as EntryPoint - awaiting Oana
- Need to restart nodes to update path?
- I want to avoid having a setup script in my service to find dotnet and call it