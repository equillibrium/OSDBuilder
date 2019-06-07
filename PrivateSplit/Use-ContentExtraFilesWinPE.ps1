function Use-ContentExtraFilesWinPE {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Use Content ExtraFiles"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($ExtraFile in $WinPEExtraFilesPE) {
        Write-Host "$OSDBuilderContent\$ExtraFile" -ForegroundColor Gray
        robocopy "$OSDBuilderContent\$ExtraFile" "$MountWinPE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentExtraFiles-WinPE.log" | Out-Null
    }
    foreach ($ExtraFile in $WinPEExtraFilesRE) {
        Write-Host "$OSDBuilderContent\$ExtraFile" -ForegroundColor Gray
        robocopy "$OSDBuilderContent\$ExtraFile" "$MountWinRE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentExtraFiles-WinRE.log" | Out-Null
    }
    foreach ($ExtraFile in $WinPEExtraFilesSE) {
        Write-Host "$OSDBuilderContent\$ExtraFile" -ForegroundColor Gray
        robocopy "$OSDBuilderContent\$ExtraFile" "$MountWinSE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-ContentExtraFiles-WinSE.log" | Out-Null
    }
}
