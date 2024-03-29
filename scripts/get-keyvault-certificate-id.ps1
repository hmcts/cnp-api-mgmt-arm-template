[CmdletBinding()]
param (
    [string]
    [ValidateNotNullOrEmpty()]
    $KeyVaultName,
    [string]
    [ValidateNotNullOrEmpty()]
    $CertificateName
    )

write-host ("##vso[task.setvariable variable=Certificate.KeyvaultId;issecret=true]{0}" -f ((Get-AzureKeyVaultSecret ($KeyVaultName) -Name ($CertificateName)).id))