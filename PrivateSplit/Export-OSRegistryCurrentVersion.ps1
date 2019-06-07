function Export-OSRegistryCurrentVersion {
    [CmdletBinding()]
    PARAM ()
    $RegCurrentVersion | Out-File "$Info\CurrentVersion.txt"
    $RegCurrentVersion | Out-File "$WorkingPath\CurrentVersion.txt"
    $RegCurrentVersion | Out-File "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-CurrentVersion.txt"
    $RegCurrentVersion | Export-Clixml -Path "$Info\xml\CurrentVersion.xml"
    $RegCurrentVersion | Export-Clixml -Path "$Info\xml\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-CurrentVersion.xml"
    $RegCurrentVersion | ConvertTo-Json | Out-File "$Info\json\CurrentVersion.json"
    $RegCurrentVersion | ConvertTo-Json | Out-File "$Info\json\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-CurrentVersion.json"
}
