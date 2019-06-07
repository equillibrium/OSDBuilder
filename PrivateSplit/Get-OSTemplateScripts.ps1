function Get-OSTemplateScripts {
    [CmdletBinding()]
    PARAM ()

    $ScriptTemplates = @()

    Write-Host "$OSDBuilderTemplates\Scripts\AutoApply\Global" -ForegroundColor DarkGray
    [array]$ScriptTemplates = Get-ChildItem "$OSDBuilderTemplates\Scripts\AutoApply\Global\*" *.ps1 -Recurse

    Write-Host "$OSDBuilderTemplates\Scripts\AutoApply\Global $OSArchitecture" -ForegroundColor DarkGray
    [array]$ScriptTemplates += Get-ChildItem "$OSDBuilderTemplates\Scripts\AutoApply\Global $OSArchitecture\*" *.ps1 -Recurse

    Write-Host "$OSDBuilderTemplates\Scripts\AutoApply\$UpdateOS" -ForegroundColor DarkGray
    [array]$ScriptTemplates += Get-ChildItem "$OSDBuilderTemplates\Scripts\AutoApply\$UpdateOS\*" *.ps1 -Recurse

    if ($OSInstallationType -notlike "*Server*") {
        Write-Host "$OSDBuilderTemplates\Scripts\AutoApply\$UpdateOS $OSArchitecture" -ForegroundColor DarkGray
        [array]$ScriptTemplates += Get-ChildItem "$OSDBuilderTemplates\Scripts\AutoApply\$UpdateOS $OSArchitecture\*" *.ps1 -Recurse
    }
    if ($OSInstallationType -notlike "*Server*" -and $OSMajorVersion -eq 10) {
        Write-Host "$OSDBuilderTemplates\Scripts\AutoApply\$UpdateOS $OSArchitecture $ReleaseId" -ForegroundColor DarkGray
        [array]$ScriptTemplates += Get-ChildItem "$OSDBuilderTemplates\Scripts\AutoApply\$UpdateOS $OSArchitecture $ReleaseId\*" *.ps1 -Recurse
    }
    Return $ScriptTemplates
}
