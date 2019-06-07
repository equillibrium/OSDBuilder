function Update-PEServicingStack {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($OSMajorVersion -ne 10) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: (SSU) Servicing Stack Update"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateSSU) {
        $UpdateSSU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -Directory -Recurse | Where-Object {$_.Name -eq $($Update.Title)}).FullName
        if (Test-Path "$UpdateSSU") {
            Write-Host "$UpdateSSU" -ForegroundColor Gray

            if (Get-WindowsPackage -Path "$MountWinPE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                Write-Warning "WinPE.wim KB$($Update.KBNumber) is already installed"
            } else {
                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ServicingStack-KB$($Update.KBNumber)-WinPE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Try {Add-WindowsPackage -Path "$MountWinPE" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
                Catch {
                    $ErrorMessage = $_.Exception.$ErrorMessage
                    Write-Host "$ErrorMessage"
                    if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
                }
            }

            if (Get-WindowsPackage -Path "$MountWinRE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                Write-Warning "WinRE.wim KB$($Update.KBNumber) is already installed"
            } else {
                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ServicingStack-KB$($Update.KBNumber)-WinRE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Try {Add-WindowsPackage -Path "$MountWinRE" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
                Catch {
                    $ErrorMessage = $_.Exception.$ErrorMessage
                    Write-Host "$ErrorMessage"
                    if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
                }
            }

            if (Get-WindowsPackage -Path "$MountWinSE" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                Write-Warning "WinSE.wim KB$($Update.KBNumber) is already installed"
            } else {
                $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ServicingStack-KB$($Update.KBNumber)-WinSE.log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Try {Add-WindowsPackage -Path "$MountWinSE" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
                Catch {
                    $ErrorMessage = $_.Exception.$ErrorMessage
                    Write-Host "$ErrorMessage"
                    if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
                }
            }
        } else {
            Write-Warning "Not Found: $UpdateSSU"
        }
    }
}
