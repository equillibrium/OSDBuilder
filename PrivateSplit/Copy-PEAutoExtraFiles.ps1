function Copy-PEAutoExtraFiles {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Auto ExtraFiles"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Write-Host "$WinPE\AutoExtraFiles" -ForegroundColor Gray
    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-AutoExtraFiles.log"

    robocopy "$WinPE\AutoExtraFiles" "$MountWinPE" *.* /e /ndl /xf bcp47*.dll /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    robocopy "$WinPE\AutoExtraFiles" "$MountWinRE" *.* /e /ndl /xf bcp47*.dll /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    robocopy "$WinPE\AutoExtraFiles" "$MountWinSE" *.* /e /ndl /xf bcp47*.dll /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    #===================================================================================================
}
