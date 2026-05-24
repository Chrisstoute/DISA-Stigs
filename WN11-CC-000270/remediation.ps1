<#
.SYNOPSIS
    Remediates DISA STIG WN11-CC-000270.

.DESCRIPTION
    This script prevents Remote Desktop Services from allowing users
    to save passwords by creating the required registry policy path
    and setting DisablePasswordSaving to 1.

.NOTES
    Author          : Chris Stoute
    Project         : DISA STIG Remediation Project
    STIG ID         : WN11-CC-000270
    Finding         : Remote Desktop Services must prevent users from saving passwords.
    Severity        : Medium / CAT II
    Date Created    : 2026-05-24
    Tested On       : Windows 11
    PowerShell Ver. : Native Windows 11 PowerShell

.USAGE
    Run PowerShell as Administrator:
    PS C:\> .\remediation.ps1
#>

Write-Host "Starting remediation for STIG WN11-CC-000270..."

# Required STIG registry policy path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "DisablePasswordSaving"
$valueData = 1

# Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    Write-Host "Registry path does not exist. Creating required path..."
    New-Item -Path $registryPath -Force | Out-Null
} else {
    Write-Host "Registry path already exists."
}

# Create or update the DisablePasswordSaving DWORD value
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

if ($result.$valueName -eq 1) {
    Write-Host "Validation Passed: $valueName is set to $($result.$valueName). RDP password saving is disabled."
} else {
    Write-Host "Validation Failed: $valueName is set to $($result.$valueName)."
}

Write-Host "STIG WN11-CC-000270 remediation completed."