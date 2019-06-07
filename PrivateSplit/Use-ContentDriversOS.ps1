function Use-ContentDriversOS {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Drivers TASK"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($Drivers) {
        foreach ($Driver in $Drivers) {
            Write-Host "$OSDBuilderContent\$Driver" -ForegroundColor Gray
            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountDirectory" /Add-Driver /Driver:"$OSDBuilderContent\$Driver" /Recurse /ForceUnsigned /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-TASK.log"
            } else {
                Add-WindowsDriver -Driver "$OSDBuilderContent\$Driver" -Recurse -Path "$MountDirectory" -ForceUnsigned -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-TASK.log" | Out-Null
            }
        }
    } else {
        Write-Host "No TASK Drivers were processed" -ForegroundColor Gray
    }

    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Drivers TEMPLATE"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($DriverTemplates) {
        foreach ($Driver in $DriverTemplates) {
            Write-Host "$($Driver.FullName)" -ForegroundColor Gray
            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountDirectory" /Add-Driver /Driver:"$($Driver.FullName)" /Recurse /ForceUnsigned /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-TEMPLATE.log"
            } else {
                Add-WindowsDriver -Driver "$($Driver.FullName)" -Recurse -Path "$MountDirectory" -ForceUnsigned -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentDrivers-TEMPLATE.log" | Out-Null
            }
        }
    } else {
        Write-Host "No TEMPLATE Drivers were processed" -ForegroundColor Gray
    }
}
