function Save-PEWindowsImageContent {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Export Image Content to $Info\Get-WindowsImageContent.txt"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Get-WindowsImageContent -ImagePath "$OS\Sources\boot.wim" -Index 1 | Out-File "$Info\Get-WindowsImageContent.txt"
}
