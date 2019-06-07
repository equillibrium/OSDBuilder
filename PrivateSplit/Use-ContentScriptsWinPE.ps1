function Use-ContentScriptsWinPE {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Use Content Scripts"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($PSWimScript in $WinPEScriptsPE) {
        if (Test-Path "$OSDBuilderContent\$PSWimScript") {
            Write-Host "Script: $OSDBuilderContent\$PSWimScript" -ForegroundColor Gray
            (Get-Content "$OSDBuilderContent\$PSWimScript").replace('winpe.wim.log', 'WinPE.log') | Set-Content "$OSDBuilderContent\$PSWimScript"
            Invoke-Expression "& '$OSDBuilderContent\$PSWimScript'"
        }
    }
    Write-Host "WinPE: WinRE.wim PowerShell Scripts"
    foreach ($PSWimScript in $WinPEScriptsRE) {
        if (Test-Path "$OSDBuilderContent\$PSWimScript") {
            Write-Host "Script: $OSDBuilderContent\$PSWimScript" -ForegroundColor Gray
            (Get-Content "$OSDBuilderContent\$PSWimScript").replace('winre.wim.log', 'WinRE.log') | Set-Content "$OSDBuilderContent\$PSWimScript"
            Invoke-Expression "& '$OSDBuilderContent\$PSWimScript'"
        }
    }
    Write-Host "WinPE: WinSE.wim PowerShell Scripts"
    foreach ($PSWimScript in $WinPEScriptsSE) {
        if (Test-Path "$OSDBuilderContent\$PSWimScript") {
            Write-Host "Script: $OSDBuilderContent\$PSWimScript" -ForegroundColor Gray
            (Get-Content "$OSDBuilderContent\$PSWimScript").replace('MountSetup', 'MountWinSE') | Set-Content "$OSDBuilderContent\$PSWimScript"
            (Get-Content "$OSDBuilderContent\$PSWimScript").replace('setup.wim.log', 'WinSE.log') | Set-Content "$OSDBuilderContent\$PSWimScript"
            Invoke-Expression "& '$OSDBuilderContent\$PSWimScript'"
        }
    }
}
