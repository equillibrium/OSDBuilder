function Add-PEContentADKWinRE {
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
    $StartTime = Get-Date
    Write-Host "[$(($StartTime).ToString('yyyy-MM-dd-HHmmss'))] WinPE: WinRE.wim ADK Optional Components" -ForegroundColor Cyan
    if ([string]::IsNullOrEmpty($WinPEADKRE) -or [string]::IsNullOrWhiteSpace($WinPEADKRE)) {
        # Do Nothing
    } else {
        $WinPEADKRE = $WinPEADKRE | Sort-Object Length
        foreach ($PackagePath in $WinPEADKRE) {
            if ($PackagePath -like "*WinPE-NetFx*") {
                Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor Gray
                Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinRE" -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage-WinRE.log" | Out-Null
            }
        }
        $WinPEADKRE = $WinPEADKRE | Where-Object {$_.Name -notlike "*WinPE-NetFx*"}
        foreach ($PackagePath in $WinPEADKRE) {
            if ($PackagePath -like "*WinPE-PowerShell*") {
                Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor Gray
                Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinRE" -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage-WinRE.log" | Out-Null
            }
        }
        $WinPEADKRE = $WinPEADKRE | Where-Object {$_.Name -notlike "*WinPE-PowerShell*"}
        foreach ($PackagePath in $WinPEADKRE) {
            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor Gray
            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountWinRE" /Add-Package /PackagePath:"$OSDBuilderContent\$PackagePath" /LogPath:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DISM-Add-WindowsPackage-WinRE.log"
            } else {
                Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinRE" -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage-WinRE.log" | Out-Null
            }
        }
    }
}
