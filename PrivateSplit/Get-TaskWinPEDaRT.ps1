function Get-TaskWinPEDaRT {
    #===================================================================================================
    #   WinPE DaRT
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEDaRT = Get-ChildItem -Path ("$OSDBuilderContent\DaRT","$OSDBuilderContent\WinPE\DaRT") *.cab -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    $WinPEDaRT = $WinPEDaRT | Where-Object {$_.FullName -like "*$($OSMedia.Arch)*"}
    foreach ($Pack in $WinPEDaRT) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEDaRT) {Write-Warning "WinPEDaRT: Add Content to $OSDBuilderContent\DaRT"}
    else {
        if ($ExistingTask.WinPEDaRT) {
            foreach ($Item in $ExistingTask.WinPEDaRT) {
                $WinPEDaRT = $WinPEDaRT | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEDaRT = $WinPEDaRT | Out-GridView -Title "WinPEDaRT: Select a WinPE DaRT Package to apply and press OK (Esc or Cancel to Skip)" -OutputMode Single
    }
    foreach ($Item in $WinPEDaRT) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEDaRT
}
