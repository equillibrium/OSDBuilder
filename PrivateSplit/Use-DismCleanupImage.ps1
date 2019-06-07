function Use-DismCleanupImage {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipComponentCleanup) {Return}
    if ($OSVersion -like "6.1*") {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: DISM Cleanup-Image"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-Cleanup-Image.log"
    if ($OSMajorVersion -eq 10) {
        if ($(Get-WindowsCapability -Path $MountDirectory | Where-Object {$_.state -eq "*pending*"})) {
            Write-Warning "Cannot run WindowsImage Cleanup on a WIM with Pending Installations"
        } else {
            Write-Verbose "CurrentLog: $CurrentLog"
            Dism /Image:"$MountDirectory" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog"
        }
    } else {
        Write-Verbose "CurrentLog: $CurrentLog"
        Dism /Image:"$MountDirectory" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog" 
    }
}
