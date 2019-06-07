function Get-TaskContentLanguageFeature {
    [CmdletBinding()]
    PARAM ()
    $LanguageFodIsoExtractDir = @()
    $LanguageFodIsoExtractDir = $ContentIsoExtract | Where-Object {$_.Name -like "*LanguageFeatures*"}
    if ($OSMedia.InstallationType -eq 'Client') {
        if ($($OSMedia.Arch) -eq 'x86') {$LanguageFodIsoExtractDir = $LanguageFodIsoExtractDir | Where-Object {$_.FullName -like "*x86*"}}
        if ($($OSMedia.Arch) -eq 'x64') {$LanguageFodIsoExtractDir = $LanguageFodIsoExtractDir | Where-Object {$_.FullName -like "*x64*" -or $_.FullName -like "*amd64*"}}
    }

    $LanguageFodUpdatesDir = @()
    if (Test-Path "$OSDBuilderContent\Updates\LanguageFeature") {
        $LanguageFodUpdatesDir = Get-ChildItem -Path "$OSDBuilderContent\Updates\LanguageFeature" *.cab -Recurse | Select-Object -Property Name, FullName
        foreach ($Package in $LanguageFodUpdatesDir) {$Package.FullName = $($Package.FullName).replace("$OSDBuilderContent\",'')}
        if ($($OSMedia.Arch) -eq 'x86') {$LanguageFodUpdatesDir = $LanguageFodUpdatesDir | Where-Object {$_.FullName -like "*x86*"}}
        if ($($OSMedia.Arch) -eq 'x64') {$LanguageFodUpdatesDir = $LanguageFodUpdatesDir | Where-Object {$_.FullName -like "*x64*" -or $_.FullName -like "*amd64*"}}
        if ($($OSMedia.ReleaseId)) {$LanguageFodUpdatesDir = $LanguageFodUpdatesDir | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}}
    }

    [array]$LanguageFeature = [array]$LanguageFodIsoExtractDir + [array]$LanguageFodUpdatesDir
    if ($null -eq $LanguageFeature) {Write-Warning "Install.wim Language Features On Demand: Not Found"}
    else {
        if ($ExistingTask.LanguageFeature) {
            foreach ($Item in $ExistingTask.LanguageFeature) {
                $LanguageFeature = $LanguageFeature | Where-Object {$_.FullName -ne $Item}
            }
        }
        $LanguageFeature = $LanguageFeature | Sort-Object -Property FullName | Out-GridView -Title "Install.wim Language Features On Demand: Select Packages to apply and press OK (Esc or Cancel to Skip)" -PassThru
        if($null -eq $LanguageFeature) {Write-Warning "Install.wim Language Features On Demand: Skipping"}
    }
    foreach ($Item in $LanguageFeature) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $LanguageFeature
}
