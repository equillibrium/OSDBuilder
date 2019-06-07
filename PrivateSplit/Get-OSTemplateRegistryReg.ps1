function Get-OSTemplateRegistryReg {
    [CmdletBinding()]
    PARAM ()

    $RegistryTemplatesRegOriginal = @()
    $RegistryTemplatesRegOriginal = Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply" *.reg -Recurse | Select-Object -Property Name, BaseName, Extension, Directory, FullName
    
    foreach ($REG in $RegistryTemplatesRegOriginal) {
        if (!(Test-Path "$($REG.FullName).Offline")) {
           Write-Host "Creating $($REG.FullName).Offline" -ForegroundColor DarkGray
           $REGContent = Get-Content -Path $REG.FullName
            $REGContent = $REGContent -replace 'HKEY_CURRENT_USER','HKEY_LOCAL_MACHINE\OfflineDefaultUser'
            $REGContent = $REGContent -replace 'HKEY_LOCAL_MACHINE\\SOFTWARE','HKEY_LOCAL_MACHINE\OfflineSoftware'
            $REGContent = $REGContent -replace 'HKEY_LOCAL_MACHINE\\SYSTEM','HKEY_LOCAL_MACHINE\OfflineSystem'
            $REGContent = $REGContent -replace 'HKEY_USERS\\.DEFAULT','HKEY_LOCAL_MACHINE\OfflineDefault'
           $REGContent | Set-Content "$($REG.FullName).Offline" -Force
        }
    }

    $RegistryTemplatesReg = @()

    Write-Host "$OSDBuilderTemplates\Registry\AutoApply\Global" -ForegroundColor DarkGray
    [array]$RegistryTemplatesReg = Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\Global\*" *.reg.Offline -Recurse

    Write-Host "$OSDBuilderTemplates\Registry\AutoApply\Global $OSArchitecture" -ForegroundColor DarkGray
    [array]$RegistryTemplatesReg += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\Global $OSArchitecture\*" *.reg.Offline -Recurse

    Write-Host "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS" -ForegroundColor DarkGray
    [array]$RegistryTemplatesReg += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS\*" *.reg.Offline -Recurse

    if ($OSInstallationType -notlike "*Server*") {
        Write-Host "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture" -ForegroundColor DarkGray
        [array]$RegistryTemplatesReg += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture\*" *.reg.Offline -Recurse
    }
    if ($OSInstallationType -notlike "*Server*" -and $OSMajorVersion -eq 10) {
        Write-Host "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture $ReleaseId" -ForegroundColor DarkGray
        [array]$RegistryTemplatesReg += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture $ReleaseId\*" *.reg.Offline -Recurse
    }
    Return $RegistryTemplatesReg
}
