# WN11-CC-000330 - WinRM Client Basic Authentication Requirement

## STIG Information

| Field | Details |
|---|---|
| STIG ID | WN11-CC-000330 |
| Finding | The Windows Remote Management client must not use Basic authentication. |
| Severity | CAT II / Medium |
| Platform | Windows 11 |
| Remediation Method | Local Group Policy and PowerShell |
| Validation Method | PowerShell validation and Tenable compliance rescan |

---

## Overview

This remediation disables Basic authentication for the Windows Remote Management client. Basic authentication can expose credentials if used insecurely, so disabling it helps reduce the risk of credential theft and unauthorized remote access.

---

## Initial Finding

Tenable identified that the system did not meet the required WinRM Client Basic authentication configuration.

![Failed Tenable Scan](Screenshots/0_Failed_WN11-CC-000330_Scan.jpg)

---

## Before Remediation

The required registry policy value was not explicitly configured before remediation.

![WinRM Client Basic Auth Before Remediation](Screenshots/1_WinRM_Client_Basic_Auth_Before_Remediation.jpg)

---

## PowerShell Remediation

The remediation script created the required registry policy path and configured `AllowBasic` as a DWORD value of `0`.

```powershell
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$valueName = "AllowBasic"
$valueData = 0

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

New-ItemProperty `
    -Path $registryPath `
    -Name $valueName `
    -Value $valueData `
    -PropertyType DWord `
    -Force | Out-Null
```

The remediation script was executed successfully and validated locally.

![PowerShell Remediation Output](Screenshots/2_PowerShell_Remediation_Output.jpg)

---

## Validation

After remediation, the registry policy value showed that WinRM Client Basic authentication was disabled.

![WinRM Client Basic Auth After Remediation](Screenshots/3_WinRM_Client_Basic_Auth_After_Remediation.jpg)

---

## Manual Remediation Reference

The manual remediation path was reviewed and documented to show how the setting can be configured through Local Group Policy Editor. The automated remediation was then implemented using PowerShell and validated locally before the final Tenable rescan.

Manual path:

```text
Local Group Policy Editor
> Computer Configuration
> Administrative Templates
> Windows Components
> Windows Remote Management (WinRM)
> WinRM Client
> Allow Basic authentication
```

Set the policy to:

```text
Disabled
```

![Manual Group Policy Path](Screenshots/4_Manual_Group_Policy_Path_WinRM_Client.jpg)

![Allow Basic Authentication Disabled](Screenshots/5_Manual_Allow_Basic_Authentication_Disabled.jpg)

![Allow Basic Authentication Disabled Configured](Screenshots/6_Manual_Allow_Basic_Authentication_Disabled_Configured.jpg)

---

## Final Tenable Validation

A follow-up Tenable compliance scan confirmed that the STIG finding was successfully remediated.

![Passed Tenable Scan](Screenshots/7_Passed_WN11-CC-000330_Scan.jpg)

---

## Security Impact

Disabling Basic authentication for the WinRM client helps prevent weak remote authentication methods from being used. This reduces the risk of credential exposure and strengthens remote management security.

---

## Status

Completed.
