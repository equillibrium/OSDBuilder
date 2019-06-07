function Show-OSMediaInfo {
    [CmdletBinding()]
    PARAM ()
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host "OSMedia Information"
    Write-Host "-OSMediaName:   $OSMediaName" -ForegroundColor Yellow
    Write-Host "-OSMediaPath:   $OSMediaPath" -ForegroundColor Yellow
    Write-Host "-OS:            $OS"
    Write-Host "-WinPE:         $WinPE"
    Write-Host "-Info:          $Info"
    Write-Host "-Logs:          $Info\logs"
}
