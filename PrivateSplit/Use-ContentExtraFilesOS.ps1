function Use-ContentExtraFilesOS {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Extra Files TASK"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($ExtraFiles) {
        foreach ($ExtraFile in $ExtraFiles) {
            Write-Host "$OSDBuilderContent\$ExtraFile" -ForegroundColor DarkGray
            robocopy "$OSDBuilderContent\$ExtraFile" "$MountDirectory" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentExtraFiles-TASK.log" | Out-Null
        }
    } else {
        Write-Host "No Task Extra Files were processed" -ForegroundColor DarkGray
    }

    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Use Content Extra Files TEMPLATE"
    if ($ExtraFilesTemplates) {
        foreach ($ExtraFile in $ExtraFilesTemplates) {
            Write-Host "$($ExtraFile.FullName)" -ForegroundColor DarkGray
            robocopy "$($ExtraFile.FullName)" "$MountDirectory" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentExtraFiles-TEMPLATE.log" | Out-Null
        }
    } else {
        Write-Host "No Template Extra Files were processed" -ForegroundColor DarkGray
    }
}
