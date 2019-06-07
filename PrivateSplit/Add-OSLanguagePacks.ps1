function Add-OSLanguagePacks {
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
    Write-Host -ForegroundColor Green "Install.wim: Language Packs"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $LanguagePacks) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            if ($Update -like "*.cab") {
                Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
                Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguagePack.log" | Out-Null
            } elseif ($Update -like "*.appx") {
                Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
                Add-AppxProvisionedPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LicensePath "$((Get-Item $OSDBuilderContent\$Update).Directory.FullName)\License.xml" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LocalExperiencePack.log" | Out-Null
            }
        } else {
            Write-Warning "Not Found: $OSDBuilderContent\$Update"
        }
    }
}
