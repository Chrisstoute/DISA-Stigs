<#
.SYNOPSIS
    Remediates DISA STIG WN11-AU-000510.

.DESCRIPTION
    This script configures the Windows System event log maximum size
    to 32768 KB or greater by creating the required registry policy path
    and setting the MaxSize DWORD value.

.NOTES
    Author          : Chris Stoute
    Project         : DISA STIG Remediation Project
    STIG ID         : WN11-AU-000510
    Finding         : The System event log size must be configured to 32768 KB or greater.
    Severity        : Medium
    Date Created    : 2026-05-23
    Tested On       : Windows 11
    PowerShell Ver. : Native Windows 11 PowerShell

.USAGE
    Run PowerShell as Administrator:
    PS C:\> .\remediation.ps1
#>

Write-Host "Starting remediation for STIG WN11-AU-000510..."

# Required STIG registry policy path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$valueData = 32768

# Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    Write-Host "Registry path does not exist. Creating required path..."
    New-Item -Path $registryPath -Force | Out-Null
} else {
    Write-Host "Registry path already exists."
}

# Create or update the MaxSize DWORD value
Write-Host "Setting $valueName to $valueData KB..."

New-ItemProperty `
    -Path $registryPath `
    -Name $valueName `
    -Value $valueData `
    -PropertyType DWord `
    -Force | Out-Null

# Validate the configuration
Write-Host "Validating registry value..."

$result = Get-ItemProperty -Path $registryPath -Name $valueName

if ($result.$valueName -ge 32768) {
    Write-Host "Validation Passed: $valueName is set to $($result.$valueName) KB."
} else {
    Write-Host "Validation Failed: $valueName is set to $($result.$valueName) KB."
}

Write-Host "STIG WN11-AU-000510 remediation completed."