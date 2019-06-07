function Update-MediaSetupDU {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Media: Setup Update"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if (!($null -eq $OSDUpdateSetupDU)) {
        foreach ($Update in $OSDUpdateSetupDU) {
            $OSDUpdateSetupDU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {$_.Name -eq $($Update.FileName)}).FullName
            $OSDUpdateSetupDU
            if (Test-Path "$OSDUpdateSetupDU") {
                expand.exe "$OSDUpdateSetupDU" -F:*.* "$OS\Sources"
            } else {
                Write-Warning "Not Found: $OSDUpdateSetupDU ... Skipping Update"
            }
        }
    }
}
