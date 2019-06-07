function Add-PEContentADKWinSE {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: WinPE.wim ADK Optional Components"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ([string]::IsNullOrEmpty($WinPEADKSE) -or [string]::IsNullOrWhiteSpace($WinPEADKSE)) {
        # Do Nothing
    } else {
        $WinPEADKSE = $WinPEADKSE | Sort-Object Length
        foreach ($PackagePath in $WinPEADKSE) {
            if ($PackagePath -like "*WinPE-NetFx*") {
                Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor Gray
                Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinSE" -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage-WinSE.log" | Out-Null
            }
        }
        $WinPEADKSE = $WinPEADKSE | Where-Object {$_.Name -notlike "*WinPE-NetFx*"}
        foreach ($PackagePath in $WinPEADKSE) {
            if ($PackagePath -like "*WinPE-PowerShell*") {
                Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor Gray
                Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinSE" -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage-WinSE.log" | Out-Null
            }
        }
        $WinPEADKSE = $WinPEADKSE | Where-Object {$_.Name -notlike "*WinPE-PowerShell*"}
        foreach ($PackagePath in $WinPEADKSE) {
            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor Gray
            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountWinSE" /Add-Package /PackagePath:"$OSDBuilderContent\$PackagePath" /LogPath:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DISM-Add-WindowsPackage-WinSE.log"
            } else {
                Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinSE" -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage-WinSE.log" | Out-Null
            }
        }
    }
}
