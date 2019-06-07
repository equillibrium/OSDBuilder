function Export-OSSessionsXml {
    [CmdletBinding()]
    PARAM (
        [string]$OSMediaPath
    )
    Write-Verbose "$OSMediaPath\Sessions.xml"
    Copy-Item "$OSMediaPath\Sessions.xml" "$OSMediaPath\info\Sessions.xml" -Force | Out-Null

    [xml]$SessionsXML = Get-Content -Path "$OSMediaPath\info\Sessions.xml"

    $Sessions = $SessionsXML.SelectNodes('Sessions/Session') | ForEach-Object {
        New-Object -Type PSObject -Property @{
            Id = $_.Tasks.Phase.package.id
            KBNumber = $_.Tasks.Phase.package.name
            TargetState = $_.Tasks.Phase.package.targetState
            Client = $_.Client
            Complete = $_.Complete
            Status = $_.Status
        }
    }
    
    $Sessions = $Sessions | Where-Object {$_.Id -like "Package*"}
    $Sessions = $Sessions | Select-Object -Property Id, KBNumber, TargetState, Client, Status, Complete | Sort-Object Complete -Descending

    $Sessions | Out-File "$OSMediaPath\Sessions.txt"
    $Sessions | Out-File "$OSMediaPath\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Sessions.txt"
    $Sessions | Export-Clixml -Path "$OSMediaPath\info\xml\Sessions.xml"
    $Sessions | Export-Clixml -Path "$OSMediaPath\info\xml\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Sessions.xml"
    $Sessions | ConvertTo-Json | Out-File "$OSMediaPath\info\json\Sessions.json"
    $Sessions | ConvertTo-Json | Out-File "$OSMediaPath\info\json\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Sessions.json"

    Remove-Item "$OSMediaPath\Sessions.xml" -Force | Out-Null
}
