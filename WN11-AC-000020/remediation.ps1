<#
.SYNOPSIS
    Remediates DISA STIG WN11-AC-000020.

.DESCRIPTION
    This script configures the local password history policy
    to remember 24 passwords in accordance with DISA STIG WN11-AC-000020.

.NOTES
    Author          : Chris Stoute
    Project         : DISA STIG Remediation Project
    STIG ID         : WN11-AC-000020
    Finding         : The password history must be configured to 24 passwords remembered.
    Severity        : Medium / CAT II
    Date Created    : 2026-05-24
    Tested On       : Windows 11
    PowerShell Ver. : Native Windows 11 PowerShell

.USAGE
    Run PowerShell as Administrator:
    PS C:\> .\remediation.ps1
#>

Write-Host "Starting remediation for STIG WN11-AC-000020..."

# Configure password history to remember 24 passwords
Write-Host "Setting password history to 24 passwords remembered..."

net accounts /uniquepw:24

# Validate the configuration
Write-Host "Validating password history policy..."

$netAccountsOutput = net accounts
$passwordHistoryLine = $netAccountsOutput | Select-String "Length of password history maintained"

Write-Host $passwordHistoryLine

if ($passwordHistoryLine -match "24") {
    Write-Host "Validation Passed: Password history is configured to remember 24 passwords."
} else {
    Write-Host "Validation Failed: Password history is not configured to remember 24 passwords."
}

Write-Host "STIG WN11-AC-000020 remediation completed."