function Save-OSDVariables {
    [CmdletBinding()]
    PARAM ()
    Get-Variable | Select-Object -Property Name, Value | Export-Clixml "$Info\xml\Variables.xml"
    Get-Variable | Select-Object -Property Name, Value | ConvertTo-Json | Out-File "$Info\json\Variables.json"
}
