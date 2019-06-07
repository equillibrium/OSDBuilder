function Expand-PEDaRT {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Expand Microsoft DaRT"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ([string]::IsNullOrEmpty($WinPEDaRT) -or [string]::IsNullOrWhiteSpace($WinPEDaRT)) {Write-Warning "Skipping WinPE DaRT"}
    elseif (Test-Path "$OSDBuilderContent\$WinPEDaRT") {
        #===================================================================================================
        Write-Host "WinPE: WinPE.wim Microsoft DaRT $OSDBuilderContent\$WinPEDaRT"
        expand.exe "$OSDBuilderContent\$WinPEDaRT" -F:*.* "$MountWinPE" | Out-Null
        if (Test-Path "$MountWinPE\Windows\System32\winpeshl.ini") {Remove-Item -Path "$MountWinPE\Windows\System32\winpeshl.ini" -Force}
        #===================================================================================================
        Write-Host "WinPE: WinRE.wim Microsoft DaRT $OSDBuilderContent\$WinPEDaRT"
        expand.exe "$OSDBuilderContent\$WinPEDaRT" -F:*.* "$MountWinRE" | Out-Null
        (Get-Content "$MountWinRE\Windows\System32\winpeshl.ini") | ForEach-Object {$_ -replace '-prompt','-network'} | Out-File "$MountWinRE\Windows\System32\winpeshl.ini"
        #===================================================================================================
        Write-Host "WinPE: WinSE.wim Microsoft DaRT $OSDBuilderContent\$WinPEDaRT"
        expand.exe "$OSDBuilderContent\$WinPEDaRT" -F:*.* "$MountWinSE" | Out-Null
        if (Test-Path "$MountWinSE\Windows\System32\winpeshl.ini") {Remove-Item -Path "$MountWinSE\Windows\System32\winpeshl.ini" -Force}
        
        if (Test-Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig.dat')) {
            Copy-Item -Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig.dat') -Destination "$MountWinPE\Windows\System32\DartConfig.dat" -Force | Out-Null
            Copy-Item -Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig.dat') -Destination "$MountWinSE\Windows\System32\DartConfig.dat" -Force | Out-Null
            Copy-Item -Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig.dat') -Destination "$MountWinRE\Windows\System32\DartConfig.dat" -Force | Out-Null
        } elseif (Test-Path $(Join-Path $(Split-Path $WinPEDart) 'DartConfig8.dat')) {
            Copy-Item -Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig8.dat') -Destination "$MountWinSE\Windows\System32\DartConfig.dat" -Force | Out-Null
            Copy-Item -Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig8.dat') -Destination "$MountWinPE\Windows\System32\DartConfig.dat" -Force | Out-Null
            Copy-Item -Path $(Join-Path $(Split-Path "$OSDBuilderContent\$WinPEDart") 'DartConfig8.dat') -Destination "$MountWinRE\Windows\System32\DartConfig.dat" -Force | Out-Null
        }
        #===================================================================================================
    } else {Write-Warning "WinPE DaRT do not exist in $OSDBuilderContent\$WinPEDart"}
}
