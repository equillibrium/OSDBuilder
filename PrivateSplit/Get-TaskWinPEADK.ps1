function Get-TaskWinPEADK {
    #===================================================================================================
    #   WinPE ADK
    #===================================================================================================
    [CmdletBinding()]
    PARAM ()
    $WinPEADK = Get-ChildItem -Path ("$OSDBuilderContent\WinPE\ADK\*","$OSDBuilderContent\ADK\*\Windows Preinstallation Environment\*\WinPE_OCs") *.cab -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    foreach ($Pack in $WinPEADK) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}
    $WinPEADK = $WinPEADK | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}

    if ($OSMedia.Arch -eq 'x86') {$WinPEADK = $WinPEADK | Where-Object {$_.FullName -like "*x86*"}
    } else {$WinPEADK = $WinPEADK | Where-Object {($_.FullName -like "*x64*") -or ($_.FullName -like "*amd64*")}}

    $WinPEADKIE = @()
    $WinPEADKIE = $ContentIsoExtractWinPE | Select-Object -Property Name, FullName
    [array]$WinPEADK = [array]$WinPEADK + [array]$WinPEADKIE

    if ($null -eq $WinPEADK) {Write-Warning "WinPE.wim ADK Packages: Add Content to $OSDBuilderContent\ADK"}
    else {
        if ($ExistingTask.WinPEADK) {
            foreach ($Item in $ExistingTask.WinPEADK) {
                $WinPEADK = $WinPEADK | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEADK = $WinPEADK | Out-GridView -Title "WinPE.wim ADK Packages: Select ADK Packages to apply and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEADK) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEADK
}
