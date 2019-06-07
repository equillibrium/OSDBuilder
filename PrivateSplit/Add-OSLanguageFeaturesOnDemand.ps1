function Add-OSLanguageFeaturesOnDemand {
    [CmdletBinding()]
    PARAM ()
    if ($OSMajorVersion -ne 10) {Return}
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Install.wim: Language Features"
    
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -notlike "*Speech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageFeatures.log" | Out-Null
        }
    }
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -like "*TextToSpeech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageFeatures.log" | Out-Null
        }
    }
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -like "*Speech*" -and $_ -notlike "*TextToSpeech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-LanguageFeatures.log" | Out-Null
        }
    }
}
