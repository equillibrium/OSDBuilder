function Add-OSWindowsPackage {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Add Packages"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($PackagePath in $Packages) {
        Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
        Try {
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountDirectory" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackage.log" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
}
