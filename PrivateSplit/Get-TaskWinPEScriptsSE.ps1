function Get-TaskWinPEScriptsSE {
    #===================================================================================================
    #   WinSE PowerShell Scripts
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEScriptsSE = Get-ChildItem -Path ("$OSDBuilderContent\Scripts","$OSDBuilderContent\WinPE\Scripts") *.ps1 -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName, Length, CreationTime | Sort-Object -Property FullName
    foreach ($TaskScript in $WinPEScriptsSE) {$TaskScript.FullName = $($TaskScript.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEScriptsSE) {Write-Warning "WinSE PowerShell Scripts: To select PowerShell Scripts add Content to $OSDBuilderContent\Scripts"}
    else {
        if ($ExistingTask.WinPEScriptsSE) {
            foreach ($Item in $ExistingTask.WinPEScriptsSE) {
                $WinPEScriptsSE = $WinPEScriptsSE | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEScriptsSE = $WinPEScriptsSE | Out-GridView -Title "WinSE PowerShell Scripts: Select PowerShell Scripts to execute and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEScriptsSE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEScriptsSE
}
