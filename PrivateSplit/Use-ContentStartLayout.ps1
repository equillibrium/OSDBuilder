function Use-ContentStartLayout {
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
    Write-Host -ForegroundColor Green "Install.wim: Use Content StartLayout"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Write-Host "$OSDBuilderContent\$StartLayoutXML" -ForegroundColor Gray
    Try {
        Copy-Item -Path "$OSDBuilderContent\$StartLayoutXML" -Destination "$MountDirectory\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml" -Recurse -Force | Out-Null
    }
    Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "$ErrorMessage"
    }
}
