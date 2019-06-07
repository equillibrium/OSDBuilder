function Update-PECumulativeForce {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
<#     if ($OSBuild -eq 18362) {
        Write-Warning "Skip: Windows 10 1903 LCU error 0x80070002"
        Return
    } #>
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: (LCU) Latest Cumulative Update Forced"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if (!($null -eq $OSDUpdateLCU)) {
        foreach ($Update in $OSDUpdateLCU) {
            $UpdateLCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -Directory -Recurse | Where-Object {$_.Name -eq $($Update.Title)}).FullName
            if (Test-Path "$UpdateLCU") {
                Write-Host "$UpdateLCU" -ForegroundColor Gray

                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateCumulative-KB$($Update.KBNumber)-WinPE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Add-WindowsPackage -Path "$MountWinPE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null
                #Dism /Image:"$MountWinPE" /Add-Package /PackagePath:"$UpdateLCU" /LogPath:"$CurrentLog"

                if (!($OSVersion -like "6.1.7601.*")) {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinPE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    if ($SkipComponentCleanup) {
                        Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
                    } else {
                        Dism /Image:"$MountWinPE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog"
                    }
                }

                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateCumulative-KB$($Update.KBNumber)-WinRE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Add-WindowsPackage -Path "$MountWinRE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null
                if (!($OSVersion -like "6.1.7601.*")) {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinRE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    if ($SkipComponentCleanup) {
                        Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
                    } else {
                        Dism /Image:"$MountWinRE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog"
                    }
                }

                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateCumulative-KB$($Update.KBNumber)-WinSE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Add-WindowsPackage -Path "$MountWinSE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null
                if (!($OSVersion -like "6.1.7601.*")) {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinSE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    if ($SkipComponentCleanup) {
                        Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
                    } else {
                        Dism /Image:"$MountWinSE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog"
                    }
                }
            } else {
                Write-Warning "Not Found: $UpdateLCU"
            }
        }
    }
}
