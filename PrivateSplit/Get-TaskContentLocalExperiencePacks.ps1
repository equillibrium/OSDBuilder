function Get-TaskContentLocalExperiencePacks {
    [CmdletBinding()]
    PARAM ()
    $LocalExperiencePacks = $ContentIsoExtract | Where-Object {$_.FullName -like "*\LocalExperiencePack\*" -and $_.Name -like "*.appx"}
    if ($OSMedia.InstallationType -eq 'Client') {$LocalExperiencePacks = $LocalExperiencePacks | Where-Object {$_.FullName -notlike "*Server*"}}
    if ($OSMedia.InstallationType -eq 'Server') {$LocalExperiencePacks = $LocalExperiencePacks | Where-Object {$_.FullName -like "*Server*"}}
    if ($OSMedia.InstallationType -eq 'Server') {$LocalExperiencePacks = $LocalExperiencePacks | Where-Object {$_.FullName -notlike "*Windows 10*"}}

    foreach ($Pack in $LocalExperiencePacks) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $LocalExperiencePacks) {Write-Warning "Install.wim Local Experience Packs: Not Found"}
    else {
        if ($ExistingTask.LocalExperiencePacks) {
            foreach ($Item in $ExistingTask.LocalExperiencePacks) {
                $LocalExperiencePacks = $LocalExperiencePacks | Where-Object {$_.FullName -ne $Item}
            }
        }
        $LocalExperiencePacks = $LocalExperiencePacks | Sort-Object -Property FullName | Out-GridView -Title "Install.wim Local Experience Packs: Select Capabilities to apply and press OK (Esc or Cancel to Skip)" -PassThru
        if ($null -eq $LocalExperiencePacks) {Write-Warning "Install.wim Local Experience Packs: Skipping"}
    }
    foreach ($Item in $LocalExperiencePacks) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $LocalExperiencePacks
}
