function Show-ActionDuration {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Show-ActionDuration
    #===================================================================================================
    $OSDDuration = $(Get-Date) - $Global:OSDStartTime
    Write-Host -ForegroundColor DarkGray "Duration: $($OSDDuration.ToString('mm\:ss'))"
    #===================================================================================================
}
