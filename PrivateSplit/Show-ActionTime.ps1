function Show-ActionTime {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Show-ActionTime
    #===================================================================================================
    $Global:OSDStartTime = Get-Date
    Write-Host -ForegroundColor Gray "$(($Global:OSDStartTime).ToString('yyyy-MM-dd-HHmmss')) " -NoNewline
    #Write-Host -ForegroundColor DarkGray "[$(($Global:OSDStartTime).ToString('yyyy-MM-dd-HHmmss'))] " -NoNewline
    #===================================================================================================
}
