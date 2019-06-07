function Set-OSLanguageSettings {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Language Settings"

    if ($SetAllIntl) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetAllIntl"
        Dism /Image:"$MountDirectory" /Set-AllIntl:"$SetAllIntl" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetAllIntl.log" | Out-Null
    }
    if ($SetInputLocale) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetInputLocale"
        Dism /Image:"$MountDirectory" /Set-InputLocale:"$SetInputLocale" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetInputLocale.log" | Out-Null
    }
    if ($SetSKUIntlDefaults) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetSKUIntlDefaults"
        Dism /Image:"$MountDirectory" /Set-SKUIntlDefaults:"$SetSKUIntlDefaults" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetSKUIntlDefaults.log" | Out-Null
    }
    if ($SetSetupUILang) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetSetupUILang"
        Dism /Image:"$MountDirectory" /Set-SetupUILang:"$SetSetupUILang" /Distribution:"$OS" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetSetupUILang.log" | Out-Null
    }
    if ($SetSysLocale) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetSysLocale"
        Dism /Image:"$MountDirectory" /Set-SysLocale:"$SetSysLocale" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetSysLocale.log" | Out-Null
    }
    if ($SetUILang) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetUILang"
        Dism /Image:"$MountDirectory" /Set-UILang:"$SetUILang" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetUILang.log" | Out-Null
    }
    if ($SetUILangFallback) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetUILangFallback"
        Dism /Image:"$MountDirectory" /Set-UILangFallback:"$SetUILangFallback" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetUILangFallback.log" | Out-Null
    }
    if ($SetUserLocale) {
        Show-ActionTime
        Write-Host -ForegroundColor Green "Install.wim: SetUserLocale"
        Dism /Image:"$MountDirectory" /Set-UserLocale:"$SetUserLocale" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-SetUserLocale.log" | Out-Null
    }
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Generating Updated Lang.ini"
    Dism /Image:"$MountDirectory" /Gen-LangIni /Distribution:"$OS" /LogPath:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dism-gen-langini.log" | Out-Null

    Update-MediaLangIni -OSMediaPath "$WorkingPath"
}
