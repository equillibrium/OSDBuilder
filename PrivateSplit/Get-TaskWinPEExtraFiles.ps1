function Get-TaskWinPEExtraFiles {
    #===================================================================================================
    #   WinPEExtraFiles
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEExtraFiles = Get-ChildItem -Path ("$OSDBuilderContent\ExtraFiles","$OSDBuilderContent\WinPE\ExtraFiles") -Directory -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    $WinPEExtraFiles = $WinPEExtraFiles | Where-Object {(Get-ChildItem $_.FullName | Measure-Object).Count -gt 0}
    foreach ($Pack in $WinPEExtraFiles) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEExtraFiles) {Write-Warning "WinPEExtraFiles: To select WinPE Extra Files, add Content to $OSDBuilderContent\ExtraFiles"}
    else {
        if ($ExistingTask.WinPEExtraFiles) {
            foreach ($Item in $ExistingTask.WinPEExtraFiles) {
                $WinPEExtraFiles = $WinPEExtraFiles | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEExtraFiles = $WinPEExtraFiles | Out-GridView -Title "WinPEExtraFiles: Select directories to inject and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEExtraFiles) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEExtraFiles
}
