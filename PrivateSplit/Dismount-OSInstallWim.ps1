function Dismount-OSInstallWim {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Dismount from $MountDirectory"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($WaitDismount.IsPresent){[void](Read-Host 'Press Enter to Continue')}
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-WindowsImage.log"
    Write-Verbose "CurrentLog: $CurrentLog"
    Start-Sleep -Seconds 10
    try {
        Dismount-WindowsImage -Path "$MountDirectory" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount Install.wim ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountDirectory" -Save -LogPath "$CurrentLog" | Out-Null
    }
    #===================================================================================================
}
