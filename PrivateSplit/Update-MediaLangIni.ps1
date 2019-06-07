function Update-MediaLangIni {
    [CmdletBinding()]
    PARAM (
        [string]$OSMediaPath
    )
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Install.wim: Updating WinSE.wim with updated Lang.ini"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    $MountWinSELangIni = Join-Path $OSDBuilderContent\Mount "winselangini$((Get-Date).ToString('hhmmss'))"
    if (!(Test-Path "$MountWinSELangIni")) {New-Item "$MountWinSELangIni" -ItemType Directory -Force | Out-Null}

    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Mount-WinSELangIni.log"
    Mount-WindowsImage -ImagePath "$OSMediaPath\WinPE\winse.wim" -Index 1 -Path "$MountWinSELangIni" -LogPath "$CurrentLog" | Out-Null

    Copy-Item -Path "$OS\Sources\lang.ini" -Destination "$MountWinSELangIni\Sources" -Force | Out-Null

    Start-Sleep -Seconds 10
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-WinSELangIni.log"
    try {
        Dismount-WindowsImage -Path "$MountWinSELangIni" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount WinSE.wim ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountWinSELangIni" -Save -LogPath "$CurrentLog" | Out-Null
    }
    if (Test-Path "$MountWinSELangIni") {Remove-Item -Path "$MountWinSELangIni" -Force -Recurse | Out-Null}

    Write-Host "Install.wim: Updating Boot.wim Index 2 with updated Lang.ini"
    $MountBootLangIni = Join-Path $OSDBuilderContent\Mount "bootlangini$((Get-Date).ToString('hhmmss'))"
    if (!(Test-Path "$MountBootLangIni")) {New-Item "$MountBootLangIni" -ItemType Directory -Force | Out-Null}

    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Mount-BootLangIni.log"
    Mount-WindowsImage -ImagePath "$OS\Sources\boot.wim" -Index 2 -Path "$MountBootLangIni" -LogPath "$CurrentLog" | Out-Null

    Copy-Item -Path "$OS\Sources\lang.ini" -Destination "$MountBootLangIni\Sources" -Force | Out-Null

    Start-Sleep -Seconds 10
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-BootLangIni.log"
    try {
        Dismount-WindowsImage -Path "$MountBootLangIni" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount Boot.wim ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountBootLangIni" -Save -LogPath "$CurrentLog" | Out-Null
    }
    if (Test-Path "$MountBootLangIni") {Remove-Item -Path "$MountBootLangIni" -Force -Recurse | Out-Null}
}
