function New-OSMediaDirectories {
    [CmdletBinding()]
    PARAM ()
    if (!(Test-Path "$Info"))           {New-Item "$Info" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$Info\json"))      {New-Item "$Info\json" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$Info\logs"))      {New-Item "$Info\logs" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$Info\xml"))       {New-Item "$Info\xml" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$OS"))             {New-Item "$OS" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$WinPE"))          {New-Item "$WinPE" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$PEInfo"))         {New-Item "$PEInfo" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$PEInfo\json"))    {New-Item "$PEInfo\json" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$PEInfo\logs"))    {New-Item "$PEInfo\logs" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$PEInfo\xml"))     {New-Item "$PEInfo\xml" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$WimTemp"))        {New-Item "$WimTemp" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$MountDirectory")) {New-Item "$MountDirectory" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$MountWinPE"))     {New-Item "$MountWinPE" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$MountWinSE"))     {New-Item "$MountWinSE" -ItemType Directory -Force | Out-Null}
    if (!(Test-Path "$MountWinRE"))     {New-Item "$MountWinRE" -ItemType Directory -Force | Out-Null}
}
