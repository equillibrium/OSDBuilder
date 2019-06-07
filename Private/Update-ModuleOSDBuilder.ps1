function Update-ModuleOSDBuilder {
    [CmdletBinding()]
    PARAM (
        [switch]$CurrentUser
    )
    #===================================================================================================
    #   Uninstall-Module
    #===================================================================================================
    Write-Warning "Uninstall-Module -Name OSDBuilder -AllVersions -Force"
    try {Uninstall-Module -Name OSDBuilder -AllVersions -Force -ErrorAction SilentlyContinue}
    catch {}
    #===================================================================================================
    #   Remove-Module
    #===================================================================================================
    Write-Warning "Remove-Module -Name OSDBuilder -Force"
    try {Remove-Module -Name OSDBuilder -Force -ErrorAction SilentlyContinue}
    catch {}
    #===================================================================================================
    #   Install-Module
    #===================================================================================================
    if ($CurrentUser.IsPresent) {
        Write-Warning "Install-Module -Name OSDBuilder -Scope CurrentUser -Force"
        try {Install-Module -Name OSDBuilder -Scope CurrentUser -Force -ErrorAction SilentlyContinue}
        catch {}
    } else {
        Write-Warning "Install-Module -Name OSDBuilder -Force"
        try {Install-Module -Name OSDBuilder -Force -ErrorAction SilentlyContinue}
        catch {}
    }
    #===================================================================================================
    #   Import-Module
    #===================================================================================================
    Write-Warning "Import-Module -Name OSDBuilder -Force"
    try {Import-Module -Name OSDBuilder -Force -ErrorAction SilentlyContinue}
    catch {}
    #===================================================================================================
    #   Close PowerShell
    #===================================================================================================
    Write-Warning "Close all open PowerShell sessions before using OSDBuilder"
}