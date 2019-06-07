function Update-PECumulative {
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
    Write-Host -ForegroundColor Green "WinPE: (LCU) Latest Cumulative Update"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateLCU) {
        $UpdateLCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -Directory -Recurse | Where-Object {$_.Name -eq $($Update.Title)}).FullName
        if (Test-Path "$UpdateLCU") {
            Write-Host "$UpdateLCU" -ForegroundColor Gray

            #if (Get-WindowsPackage -Path "$MountWinPE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {}
            $SessionsXmlWinPE = "$MountWinPE\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlWinPE) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlWinPE
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.KBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Warning "WinPE.wim KB$($Update.KBNumber) is already installed"
                } else {
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
                }
            } else {
                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateCumulative-KB$($Update.KBNumber)-WinPE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Add-WindowsPackage -Path "$MountWinPE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null
                if (!($OSVersion -like "6.1.7601.*")) {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinPE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    if ($SkipComponentCleanup) {
                        Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
                    } else {
                        Dism /Image:"$MountWinPE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog"
                    }
                }
            }

            #if (Get-WindowsPackage -Path "$MountWinRE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {}
            $SessionsXmlWinRE = "$MountWinRE\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlWinRE) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlWinRE
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.KBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Warning "WinRE.wim KB$($Update.KBNumber) is already installed"
                } else {
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
                }
            } else {
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
            }

            #if (Get-WindowsPackage -Path "$MountWinSE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {}
            $SessionsXmlSetup = "$MountWinSE\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlSetup) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlSetup
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.KBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Warning "WinSE.wim KB$($Update.KBNumber) is already installed"
                } else {
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
                }
            } else {
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
            }
        } else {
            Write-Warning "Not Found: $UpdateLCU"
        }
    }
}
