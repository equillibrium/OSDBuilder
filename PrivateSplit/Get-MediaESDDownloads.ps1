function Get-MediaESDDownloads {
    $MediaESDDownloads = @()
    $CatalogsXmls = @()
    $CatalogsXmls = Get-ChildItem "$($MyInvocation.MyCommand.Module.ModuleBase)\CatalogsESD\*" -Include *.xml
    foreach ($CatalogsXml in $CatalogsXmls) {
        $MediaESDDownloads += Import-Clixml -Path "$($CatalogsXml.FullName)"
    }
    #===================================================================================================
    #   Get Downloadeds
    #===================================================================================================
    foreach ($Download in $MediaESDDownloads) {
        $FullUpdatePath = "$OSDBuilderPath\MediaESD\$($Update.FileName)"
        if (Test-Path $FullUpdatePath) {
            $Download.OSDStatus = "Downloaded"
        }
    }
    #===================================================================================================
    #   Return
    #===================================================================================================
    $MediaESDDownloads = $MediaESDDownloads | Select-Object -Property *
    Return $MediaESDDownloads
}
