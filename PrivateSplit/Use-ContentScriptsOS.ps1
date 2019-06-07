function Use-ContentScriptsOS {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Scripts TASK"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($Scripts) {
        foreach ($Script in $Scripts) {
            if (Test-Path "$OSDBuilderContent\$Script") {
                Write-Host "Script: $OSDBuilderContent\$Script"
                Invoke-Expression "& '$OSDBuilderContent\$Script'"
            }
        }
    } else {
        Write-Host "No Task Scripts were processed" -ForegroundColor Gray
    }

    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Scripts TEMPLATE"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($ScriptTemplates) {
        foreach ($Script in $ScriptTemplates) {
            if (Test-Path "$($Script.FullName)") {
                Write-Host "Script: $($Script.FullName)"
                Invoke-Expression "& '$($Script.FullName)'"
            }
        }
    } else {
        Write-Host "No Template Scripts were processed" -ForegroundColor Gray
    }
}
