function Copy-MediaLanguageSources {
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
    Write-Host -ForegroundColor Green "Install.wim: Language Sources"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($LanguageSource in $LanguageCopySources) {
        $CurrentLanguageSource = Get-OSMedia -Revision OK | Where-Object {$_.OSMFamily -eq $LanguageSource} | Select-Object -Property FullName
        Write-Host "Copying Language Resources from $($CurrentLanguageSource.FullName)" -ForegroundColor DarkGray
        robocopy "$($CurrentLanguageSource.FullName)\OS" "$OS" *.* /e /xf *.wim /ndl /xc /xn /xo /xf /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageSources.log" | Out-Null
    }
    #===================================================================================================
}
