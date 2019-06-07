function Get-TaskWinPEADKPE {
    #===================================================================================================
    #   WinPE ADK
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEADKPE = Get-ChildItem -Path ("$OSDBuilderContent\WinPE\ADK\*","$OSDBuilderContent\ADK\*\Windows Preinstallation Environment\*\WinPE_OCs") *.cab -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    foreach ($Pack in $WinPEADKPE) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}
    $WinPEADKPE = $WinPEADKPE | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}

    if ($OSMedia.Arch -eq 'x86') {$WinPEADKPE = $WinPEADKPE | Where-Object {$_.FullName -like "*x86*"}
    } else {$WinPEADKPE = $WinPEADKPE | Where-Object {($_.FullName -like "*x64*") -or ($_.FullName -like "*amd64*")}}

    $WinPEADKPEIE = @()
    $WinPEADKPEIE = $ContentIsoExtractWinPE | Select-Object -Property Name, FullName
    [array]$WinPEADKPE = [array]$WinPEADKPE + [array]$WinPEADKPEIE

    if ($null -eq $WinPEADKPE) {Write-Warning "WinPE.wim ADK Packages: Add Content to $OSDBuilderContent\ADK"}
    else {
        if ($ExistingTask.WinPEADKPE) {
            foreach ($Item in $ExistingTask.WinPEADKPE) {
                $WinPEADKPE = $WinPEADKPE | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEADKPE = $WinPEADKPE | Out-GridView -Title "WinPE.wim ADK Packages: Select ADK Packages to apply and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEADKPE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEADKPE
}
