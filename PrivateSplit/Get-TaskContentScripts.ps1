function Get-TaskContentScripts {
    #===================================================================================================
    #   Content Scripts
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $Scripts = Get-ChildItem -Path "$OSDBuilderContent\Scripts" *.ps1 -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName, Length, CreationTime | Sort-Object -Property FullName
    foreach ($Item in $Scripts) {$Item.FullName = $($Item.FullName).replace("$OSDBuilderContent\",'')}

    if ($null -eq $Scripts) {Write-Warning "Scripts: To select PowerShell Scripts add Content to $OSDBuilderContent\Scripts"}
    else {
        if ($ExistingTask.Scripts) {
            foreach ($Item in $ExistingTask.Scripts) {
                $Scripts = $Scripts | Where-Object {$_.FullName -ne $Item}
            }
        }
        $Scripts = $Scripts | Out-GridView -Title "Scripts: Select PowerShell Scripts to execute and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $Scripts) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $Scripts
}
