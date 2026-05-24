<#
.SYNOPSIS
    Remediates DISA STIG WN11-AC-000010.

.DESCRIPTION
    This script configures the local account lockout threshold
    to 3 invalid logon attempts in accordance with DISA STIG WN11-AC-000010.

.NOTES
    Author          : Chris Stoute
    Project         : DISA STIG Remediation Project
    STIG ID         : WN11-AC-000010
    Finding         : The number of allowed bad logon attempts must be configured to 3 or fewer.
    Severity        : Medium / CAT II
    Date Created    : 2026-05-24
    Tested On       : Windows 11
    PowerShell Ver. : Native Windows 11 PowerShell

.USAGE
    Run PowerShell as Administrator:
    PS C:\> .\remediation.ps1
#>

Write-Host "Starting remediation for STIG WN11-AC-000010..."

# Configure account lockout threshold to 3 invalid logon attempts
Write-Host "Setting account lockout threshold to 3 invalid logon attempts..."

net accounts /lockoutthreshold:3

# Validate the configuration
Write-Host "Validating account lockout threshold..."

$netAccountsOutput = net accounts
$lockoutThresholdLine = $netAccountsOutput | Select-String "Lockout threshold"

Write-Host $lockoutThresholdLine

if ($lockoutThresholdLine -match "3") {
    Write-Host "Validation Passed: Account lockout threshold is configured to 3 invalid logon attempts."
} else {
    Write-Host "Validation Failed: Account lockout threshold is not configured to 3 invalid logon attempts."
}

Write-Host "STIG WN11-AC-000010 remediation completed."