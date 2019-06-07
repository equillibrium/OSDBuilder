function Get-TaskContentLanguageCopySources {
    #===================================================================================================
    #   Content Scripts
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $LanguageCopySources = Get-OSMedia -Revision OK
    $LanguageCopySources = $LanguageCopySources | Where-Object {$_.Arch -eq $OSMedia.Arch}
    $LanguageCopySources = $LanguageCopySources | Where-Object {$_.Build -eq $OSMedia.Build}
    $LanguageCopySources = $LanguageCopySources | Where-Object {$_.OperatingSystem -eq $OSMedia.OperatingSystem}
    $LanguageCopySources = $LanguageCopySources | Where-Object {$_.OSMFamily -ne $OSMedia.OSMFamily}

    if ($ExistingTask.LanguageCopySources) {
        foreach ($Item in $ExistingTask.LanguageCopySources) {
            $LanguageCopySources = $LanguageCopySources | Where-Object {$_.OSMFamily -ne $Item}
        }
    }
    $LanguageCopySources = $LanguageCopySources | Out-GridView -Title "SourcesLanguageCopy: Select OSMedia to copy the Language Sources and press OK (Esc or Cancel to Skip)" -PassThru

    foreach ($Item in $LanguageCopySources) {Write-Host "$($Item.OSMFamily)" -ForegroundColor White}
    Return $LanguageCopySources
}
