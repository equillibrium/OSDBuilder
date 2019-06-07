function Update-OSWindowsSeven {
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
    Write-Host -ForegroundColor Green "Install.wim: Windows 7 Updates"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateWinSeven) {
        $UpdateSeven = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -Directory -Recurse | Where-Object {$_.Name -eq $($Update.Title)}).FullName
        if (Test-Path "$UpdateSeven") {
            Write-Host "$UpdateSeven" -ForegroundColor Gray
            if (Get-WindowsPackage -Path "$MountDirectory" | Where-Object {$_.PackageName -like "*$($Update.KBNumber)*"}) {
                Write-Warning "KB$($Update.KBNumber) is already installed"
            } else {
                $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-UpdateSeven-KB$($Update.KBNumber).log"
                Write-Verbose "CurrentLog: $CurrentLog"
                Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateSeven" -LogPath "$CurrentLog" | Out-Null}
                Catch {
                    $ErrorMessage = $_.Exception.$ErrorMessage
                    Write-Host "$ErrorMessage"
                    if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
                }
            }
        } else {
            Write-Warning "Not Found: $UpdateSeven"
        }
    }
}
