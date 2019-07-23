[CmdletBinding()]
param (
    [string]
    [ValidateNotNullOrEmpty()]
    $ResourceGroupName,
    [string]
    [ValidateNotNullOrEmpty()]
    $ApiManagementName,
    [string]
    [ValidateNotNullOrEmpty()]
    $KeyVaultId,
    [string]
    [ValidateNotNullOrEmpty()]
    $EnvironmentName,
    [string]
    [ValidateNotNullOrEmpty()]
    $CustomDomainName,
    [string]
    $ProxyPrefix = 'apim',
    [string]
    $MgmtPrefix = 'apim-mgmt',
    [string]
    $PortalPrefix = 'apim-portal'
)

$hostSuffix  = ('-{0}.{1}' -f $environmentName, $customDomainName)
$mgmtName = ('{0}{1}' -f $MgmtPrefix, $hostSuffix)
$portalName = ('{0}{1}' -f $PortalPrefix, $hostSuffix)
$proxyName = ('{0}{1}' -f $ProxyPrefix, $hostSuffix)

$VerbosePreference = "Continue"

$ApiInstance = Get-AzureRmApiManagement -ResourceGroupName $ResourceGroupName -Name  $ApiManagementName

$UpdateAPIM = $false

# Portal
if ($ApiInstance.PortalCustomHostnameConfiguration.KeyVaultId -eq $KeyVaultId  -and $ApiInstance.PortalCustomHostnameConfiguration.Hostname -eq $portalName)
{
    write-verbose 'Portal config already set'
}
else
{
    $ApiInstance.PortalCustomHostnameConfiguration = New-AzureRmApiManagementCustomHostnameConfiguration -Hostname $portalName -HostnameType Portal -KeyVaultId $KeyVaultId 
    $UpdateAPIM = $true
}

# Management
if ($ApiInstance.ManagementCustomHostnameConfiguration.KeyVaultId -eq $KeyVaultId  -and $ApiInstance.ManagementCustomHostnameConfiguration.Hostname -eq $mgmtName )
{
    write-verbose 'Management config already set'
}
else
{
    $ApiInstance.ManagementCustomHostnameConfiguration = New-AzureRmApiManagementCustomHostnameConfiguration -Hostname $mgmtName  -HostnameType Management -KeyVaultId $KeyVaultId 
    $UpdateAPIM = $true
}

# Proxy
if ($ApiInstance.ProxyCustomHostnameConfiguration.KeyVaultId -eq $KeyVaultId  -and $ApiInstance.ProxyCustomHostnameConfiguration.Hostname -eq $proxyName)
{
    write-verbose 'Proxy config already set'
}
else
{
    $ApiInstance.ProxyCustomHostnameConfiguration = New-AzureRmApiManagementCustomHostnameConfiguration -Hostname $proxyName -HostnameType Proxy -KeyVaultId $KeyVaultId 
    $UpdateAPIM = $true
}

if ($UpdateAPIM)
{
    Set-AzureRmApiManagement -InputObject $ApiInstance   
}
else
{
    Write-Output 'No updates to APIM required'
}