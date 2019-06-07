function Show-OSMediaImageInfo {
    [CmdletBinding()]
    PARAM ()
    #===================================================================================================
    #   Show-OSMediaImageInfo
    #===================================================================================================
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "Source OSMedia Windows Image Information"
    Write-Host "-OSMedia Path:                  $OSMediaPath" -ForegroundColor Yellow
    Write-Host "-Image File:                    $OSImagePath"
    Write-Host "-Image Index:                   $OSImageIndex"
    Write-Host "-Name:                          $OSImageName"
    Write-Host "-Description:                   $OSImageDescription"
    Write-Host "-Architecture:                  $OSArchitecture"
    Write-Host "-Edition:                       $OSEditionID"
    Write-Host "-Type:                          $OSInstallationType"
    Write-Host "-Languages:                     $OSLanguages"
    Write-Host "-Major Version:                 $OSMajorVersion"
    Write-Host "-Build:                         $OSBuild"
    Write-Host "-Version:                       $OSVersion"
    Write-Host "-SPBuild:                       $OSSPBuild"
    Write-Host "-SPLevel:                       $OSSPLevel"
    Write-Host "-Bootable:                      $OSImageBootable"
    Write-Host "-WimBoot:                       $OSWIMBoot"
    Write-Host "-Created Time:                  $OSCreatedTime"
    Write-Host "-Modified Time:                 $OSModifiedTime"
}
