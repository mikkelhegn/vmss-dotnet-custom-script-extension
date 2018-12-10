Param(
    [string]$dotnetInstallDir = 'C:\dotnet',
    [string]$dotnetVersion = 'Latest',
    [string]$dotnetChannel = '2.0'
)

# Set system path to dotnet installation
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$dotnetInstallDir", [EnvironmentVariableTarget]::Machine);

# Force use of TLS12 to download script
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Download and run dotnet-install.ps1
&([scriptblock]::Create((Invoke-WebRequest "https://dot.net/v1/dotnet-install.ps1" -UseBasicParsing))) -Runtime dotnet -Channel $dotnetChannel -Version $dotnetVersion -InstallDir $dotnetInstallDir -NoPath;