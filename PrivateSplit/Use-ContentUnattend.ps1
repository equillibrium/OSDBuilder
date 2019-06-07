function Use-ContentUnattend {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($OSMajorVersion -ne 10) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Unattend"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Write-Host "$OSDBuilderContent\$UnattendXML" -ForegroundColor DarkGray
    if (!(Test-Path "$MountDirectory\Windows\Panther")) {New-Item -Path "$MountDirectory\Windows\Panther" -ItemType Directory -Force | Out-Null}
    Copy-Item -Path "$OSDBuilderContent\$UnattendXML" -Destination "$MountDirectory\Windows\Panther\Unattend.xml" -Force
    Try {Use-WindowsUnattend -UnattendPath "$OSDBuilderContent\$UnattendXML" -Path "$MountDirectory" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentUnattend.log" | Out-Null}
    Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "$ErrorMessage"
    }
}
