function Use-ContentDriversWinPE {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Use Content Drivers"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($WinPEDrivers) {
        foreach ($WinPEDriver in $WinPEDrivers) {
            Write-Host "$OSDBuilderContent\$WinPEDriver" -ForegroundColor Gray
            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountWinPE" /Add-Driver /Driver:"$OSDBuilderContent\$WinPEDriver" /Recurse /ForceUnsigned /LogPath:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-WinPE.log"
                dism /Image:"$MountWinRE" /Add-Driver /Driver:"$OSDBuilderContent\$WinPEDriver" /Recurse /ForceUnsigned /LogPath:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-WinRE.log"
                dism /Image:"$MountWinSE" /Add-Driver /Driver:"$OSDBuilderContent\$WinPEDriver" /Recurse /ForceUnsigned /LogPath:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-WinSE.log"
            } else {
                Add-WindowsDriver -Path "$MountWinPE" -Driver "$OSDBuilderContent\$WinPEDriver" -Recurse -ForceUnsigned -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-WinPE.log" | Out-Null
                Add-WindowsDriver -Path "$MountWinRE" -Driver "$OSDBuilderContent\$WinPEDriver" -Recurse -ForceUnsigned -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-WinRE.log" | Out-Null
                Add-WindowsDriver -Path "$MountWinSE" -Driver "$OSDBuilderContent\$WinPEDriver" -Recurse -ForceUnsigned -LogPath "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-WinSE.log" | Out-Null
            }
        }
    } else {
        Write-Host "No TASK WinPE Drivers were processed" -ForegroundColor Gray
    }
}
