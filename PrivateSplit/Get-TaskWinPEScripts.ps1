function Get-TaskWinPEScripts {
    #===================================================================================================
    #   WinPE PowerShell Scripts
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEScripts = Get-ChildItem -Path ("$OSDBuilderContent\Scripts","$OSDBuilderContent\WinPE\Scripts") *.ps1 -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName, Length, CreationTime | Sort-Object -Property FullName
    foreach ($TaskScript in $WinPEScripts) {$TaskScript.FullName = $($TaskScript.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEScripts) {Write-Warning "WinPE PowerShell Scripts: To select PowerShell Scripts add Content to $OSDBuilderContent\Scripts"}
    else {
        if ($ExistingTask.WinPEScripts) {
            foreach ($Item in $ExistingTask.WinPEScripts) {
                $WinPEScripts = $WinPEScripts | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEScripts = $WinPEScripts | Out-GridView -Title "WinPE PowerShell Scripts: Select PowerShell Scripts to execute and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEScripts) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEScripts
}
