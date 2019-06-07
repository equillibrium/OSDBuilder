function Add-OSFeaturesOnDemand {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Features On Demand"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($FOD in $FeaturesOnDemand) {
        Write-Host $FOD -ForegroundColor DarkGray
        $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-FOD.log"
        Try {
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$FOD" -LogPath "$CurrentLog" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
    Update-OSCumulativeForce
    Use-DismCleanupImage
}
