<#
.SYNOPSIS
    Remediates DISA STIG WN11-AC-000035.

.DESCRIPTION
    This script configures the local minimum password length policy
    to require at least 14 characters in accordance with DISA STIG WN11-AC-000035.

.NOTES
    Author          : Chris Stoute
    Project         : DISA STIG Remediation Project
    STIG ID         : WN11-AC-000035
    Finding         : The minimum password length must be configured to 14 characters.
    Severity        : Medium / CAT II
    Date Created    : 2026-05-24
    Tested On       : Windows 11
    PowerShell Ver. : Native Windows 11 PowerShell

.USAGE
    Run PowerShell as Administrator:
    PS C:\> .\remediation.ps1
#>

Write-Host "Starting remediation for STIG WN11-AC-000035..."

# Configure minimum password length to 14 characters
Write-Host "Setting minimum password length to 14 characters..."

net accounts /minpwlen:14

# Validate the configuration
Write-Host "Validating minimum password length policy..."

$netAccountsOutput = net accounts
$minimumPasswordLengthLine = $netAccountsOutput | Select-String "Minimum password length"

Write-Host $minimumPasswordLengthLine

if ($minimumPasswordLengthLine -match "14") {
    Write-Host "Validation Passed: Minimum password length is configured to 14 characters."
} else {
    Write-Host "Validation Failed: Minimum password length is not configured to 14 characters."
}

Write-Host "STIG WN11-AC-000035 remediation completed."