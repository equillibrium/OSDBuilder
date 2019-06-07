function Update-PEWindowsSeven {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($OSMajorVersion -eq 10) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Windows 7 Updates"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateWinSeven) {
        if ($Update.UpdateGroup -eq 'SSU' -or $Update.UpdateGroup -eq 'LCU') {
            $UpdateWinPESeven = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -Directory -Recurse | Where-Object {$_.Name -eq $($Update.Title)}).FullName
            if (Test-Path "$UpdateWinPESeven") {
                Write-Host "$UpdateWinPESeven" -ForegroundColor Gray
    
                if (Get-WindowsPackage -Path "$MountWinSE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                    Write-Warning "WinSE.wim KB$($Update.KBNumber) is already installed"
                } else {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateWinPESeven-KB$($Update.KBNumber)-WinSE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    Add-WindowsPackage -Path "$MountWinSE" -PackagePath "$UpdateWinPESeven" -LogPath "$CurrentLog" | Out-Null
                }
    
                if (Get-WindowsPackage -Path "$MountWinPE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                    Write-Warning "WinPE.wim KB$($Update.KBNumber) is already installed"
                } else {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateWinPESeven-KB$($Update.KBNumber)-WinPE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    Add-WindowsPackage -Path "$MountWinPE" -PackagePath "$UpdateWinPESeven" -LogPath "$CurrentLog" | Out-Null
                }
    
                if (Get-WindowsPackage -Path "$MountWinRE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                    Write-Warning "WinRE.wim KB$($Update.KBNumber) is already installed"
                } else {
                    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateWinPESeven-KB$($Update.KBNumber)-WinRE.log"
                    Write-Verbose "CurrentLog: $CurrentLog"
                    Add-WindowsPackage -Path "$MountWinRE" -PackagePath "$UpdateWinPESeven" -LogPath "$CurrentLog" | Out-Null
                }
            } else {
                Write-Warning "Not Found: $UpdateWinPESeven ... Skipping Update"
            }
        }
    }
}
