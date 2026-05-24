<#
.SYNOPSIS
    Remediates DISA STIG WN11-CC-000350.

.DESCRIPTION
    This script disables unencrypted traffic for the Windows Remote Management
    client by creating the required registry policy path and setting
    AllowUnencryptedTraffic to 0.

.NOTES
    Author          : Chris Stoute
    Project         : DISA STIG Remediation Project
    STIG ID         : WN11-CC-000350
    Finding         : The Windows Remote Management client must not allow unencrypted traffic.
    Severity        : Medium / CAT II
    Date Created    : 2026-05-24
    Tested On       : Windows 11
    PowerShell Ver. : Native Windows 11 PowerShell

.USAGE
    Run PowerShell as Administrator:
    PS C:\> .\remediation.ps1
#>

Write-Host "Starting remediation for STIG WN11-CC-000350..."

# Required STIG registry policy path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$valueName = "AllowUnencryptedTraffic"
$valueData = 0

# Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    Write-Host "Registry path does not exist. Creating required path..."
    New-Item -Path $registryPath -Force | Out-Null
} else {
    Write-Host "Registry path already exists."
}

# Create or update the AllowUnencryptedTraffic DWORD value
Write-Host "Setting $valueName to $valueData..."

New-ItemProperty `
    -Path $registryPath `
    -Name $valueName `
    -Value $valueData `
    -PropertyType DWord `
    -Force | Out-Null

# Validate the configuration
Write-Host "Validating registry value..."

$result = Get-ItemProperty -Path $registryPath -Name $valueName

if ($result.$valueName -eq 0) {
    Write-Host "Validation Passed: $valueName is set to $($result.$valueName). WinRM Client unencrypted traffic is disabled."
} else {
    Write-Host "Validation Failed: $valueName is set to $($result.$valueName)."
}

Write-Host "STIG WN11-CC-000350 remediation completed."