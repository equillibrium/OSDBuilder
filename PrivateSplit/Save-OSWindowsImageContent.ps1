function Save-OSWindowsImageContent {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Export Image Content to $Info\Get-WindowsImageContent.txt"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Get-WindowsImageContent -ImagePath "$OS\Sources\install.wim" -Index 1 | Out-File "$Info\Get-WindowsImageContent.txt"
}
