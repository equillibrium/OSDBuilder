function Get-TaskContentLanguageInterfacePack {
    [CmdletBinding()]
    PARAM ()
    $LanguageLipIsoExtractDir = @()
    $LanguageLipIsoExtractDir = $ContentIsoExtract | Where-Object {$_.Name -like "*Language-Interface-Pack*"}
    $LanguageLipIsoExtractDir = $LanguageLipIsoExtractDir | Where-Object {$_.Name -like "*$($OSMedia.Arch)*"}

    $LanguageLipUpdatesDir = @()
    if (Test-Path "$OSDBuilderContent\Updates\LanguageInterfacePack") {
        $LanguageLipUpdatesDir = Get-ChildItem -Path "$OSDBuilderContent\Updates\LanguageInterfacePack" *.cab -Recurse | Select-Object -Property Name, FullName
        foreach ($Package in $LanguageLipUpdatesDir) {$Package.FullName = $($Package.FullName).replace("$OSDBuilderContent\",'')}
        $LanguageLipUpdatesDir = $LanguageLipUpdatesDir | Where-Object {$_.FullName -like "*$($OSMedia.Arch)*"}
        if ($($OSMedia.ReleaseId)) {$LanguageLipUpdatesDir = $LanguageLipUpdatesDir | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}}
    }
    
    [array]$LanguageInterfacePack = [array]$LanguageLipIsoExtractDir + [array]$LanguageLipUpdatesDir
    if ($null -eq $LanguageInterfacePack) {Write-Warning "Install.wim Language Interface Packs: Not Found"}
    else {
        if ($ExistingTask.LanguageInterfacePack) {
            foreach ($Item in $ExistingTask.LanguageInterfacePack) {
                $LanguageInterfacePack = $LanguageInterfacePack | Where-Object {$_.FullName -ne $Item}
            }
        }
        $LanguageInterfacePack = $LanguageInterfacePack | Sort-Object -Property FullName | Out-GridView -Title "Install.wim Language Interface Packs: Select Packages to apply and press OK (Esc or Cancel to Skip)" -PassThru
        if($null -eq $LanguageInterfacePack) {Write-Warning "Install.wim Language Interface Packs: Skipping"}
    }
    foreach ($Item in $LanguageInterfacePack) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $LanguageInterfacePack
}
