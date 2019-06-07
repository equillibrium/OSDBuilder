function Update-OSServicingStackForce {
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
    Write-Host -ForegroundColor Green "Install.wim: (SSU) Servicing Stack Update Forced"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateSSU) {
        $UpdateSSU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -Directory -Recurse | Where-Object {$_.Name -eq $($Update.Title)}).FullName
        if (Test-Path "$UpdateSSU") {
            Write-Host "$UpdateSSU" -ForegroundColor Gray
            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ServicingStack-KB$($Update.KBNumber).log"
            Write-Verbose "CurrentLog: $CurrentLog"
            Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
            Catch {
                $ErrorMessage = $_.Exception.$ErrorMessage
                Write-Host "$ErrorMessage"
                if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
            }
        } else {
            Write-Warning "Not Found: $UpdateSSU"
        }
    }
}
