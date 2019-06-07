function Enable-OSDWindowsOptionalFeature {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Enable Windows Optional Feature"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($FeatureName in $EnableFeature) {
        Write-Host $FeatureName -ForegroundColor DarkGray
        Try {
            Enable-WindowsOptionalFeature -FeatureName $FeatureName -Path "$MountDirectory" -All -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Enable-WindowsOptionalFeature.log" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
    #===================================================================================================
    #   Post Action
    #===================================================================================================
    Update-OSCumulativeForce
    Use-DismCleanupImage
    #===================================================================================================
}
