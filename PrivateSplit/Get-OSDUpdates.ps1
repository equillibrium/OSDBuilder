function Get-OSDUpdates {
    $AllOSDUpdates = @()
    $CatalogsXmls = @()
    $CatalogsXmls = Get-ChildItem "$($MyInvocation.MyCommand.Module.ModuleBase)\Catalogs\*" -Include *.xml
    foreach ($CatalogsXml in $CatalogsXmls) {
        $AllOSDUpdates += Import-Clixml -Path "$($CatalogsXml.FullName)"
    }
    #===================================================================================================
    #   Standard Filters
    #===================================================================================================
    $AllOSDUpdates = $AllOSDUpdates | Where-Object {$_.FileName -notlike "*.exe"}
    $AllOSDUpdates = $AllOSDUpdates | Where-Object {$_.FileName -notlike "*.psf"}
    $AllOSDUpdates = $AllOSDUpdates | Where-Object {$_.FileName -notlike "*.txt"}
    $AllOSDUpdates = $AllOSDUpdates | Where-Object {$_.FileName -notlike "*delta.exe"}
    $AllOSDUpdates = $AllOSDUpdates | Where-Object {$_.FileName -notlike "*express.cab"}
    $AllOSDUpdates = $AllOSDUpdates | Where-Object {$_.Title -notlike "* Next *"}
    #===================================================================================================
    #   Get Downloaded Updates
    #===================================================================================================
    foreach ($Update in $AllOSDUpdates) {
        $FullUpdatePath = "$OSDBuilderPath\Content\OSDUpdate\$($Update.Catalog)\$($Update.Title)\$($Update.FileName)"
        if (Test-Path $FullUpdatePath) {
            $Update.OSDStatus = "Downloaded"
        }
    }
    #===================================================================================================
    #   Return
    #===================================================================================================
    $AllOSDUpdates = $AllOSDUpdates | Select-Object -Property *
    Return $AllOSDUpdates
}
