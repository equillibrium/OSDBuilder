function Get-TaskWinPEScriptsRE {
    #===================================================================================================
    #   WinRE PowerShell Scripts
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEScriptsRE = Get-ChildItem -Path ("$OSDBuilderContent\Scripts","$OSDBuilderContent\WinPE\Scripts") *.ps1 -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName, Length, CreationTime | Sort-Object -Property FullName
    foreach ($TaskScript in $WinPEScriptsRE) {$TaskScript.FullName = $($TaskScript.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEScriptsRE) {Write-Warning "WinRE PowerShell Scripts: To select PowerShell Scripts add Content to $OSDBuilderContent\Scripts"}
    else {
        if ($ExistingTask.WinPEScriptsRE) {
            foreach ($Item in $ExistingTask.WinPEScriptsRE) {
                $WinPEScriptsRE = $WinPEScriptsRE | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEScriptsRE = $WinPEScriptsRE | Out-GridView -Title "WinRE PowerShell Scripts: Select PowerShell Scripts to execute and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEScriptsRE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEScriptsRE
}
