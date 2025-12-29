@echo off
setlocal enabledelayedexpansion
:: Скрипт создает резервную копию пользовательских файлов и некоторых программ. Запускать только со стороннего накопителя большего обьема.

set XOPT=/V /D /H /J /E /Y /R

set "LOCAL=Users\%USERNAME%\AppData\Local"
set "LOCALLOW=Users\%USERNAME%\AppData\LocalLow"
set "ROAMING=Users\%USERNAME%\AppData\Roaming"

set "exclusions_C=exclusions\C.txt"
set "exclusions_ProgramFiles=exclusions\Program Files.txt"
set "exclusions_ProgramFiles_x86=exclusions\Program Files (x86).txt"
set "exclusions_CommonFiles=exclusions\Program Files (x86) Common Files.txt"
set "exclusions_ProgramData=exclusions\ProgramData.txt"
set "exclusions_Local=exclusions\Local.txt"
set "exclusions_LocalLow=exclusions\LocalLow.txt"
set "exclusions_Roaming=exclusions\Roaming.txt"

set "exclusions_UserProfile_Folders=exclusions\UserProfile_Folders.txt"
set "exclusions_User_File=exclusions\User_Files.txt"

if not exist "exclusions\" (
    mkdir "exclusions" 2>nul
)

if not exist "Backup\" (
    mkdir "Backup" 2>nul
)

if not exist "exclusions\C.txt" (
    (
    echo $Recycle.Bin
    echo $WinREAgent
    echo $WINDOWS.~BT
    echo inetpub
    echo Log Files
    echo OneDriveTemp
    echo PerfLogs
    echo Program Files
    echo Program Files (x86^)
    echo ProgramData
    echo Recovery
    echo stable-diffusion
    echo SWSetup
    echo Users
    echo Windows
    echo XboxGames
    ) > "exclusions\C.txt"
)

if not exist "exclusions\Program Files.txt" (
    (
    echo Application Verifier
    echo Common Files
    echo dotnet
    echo Elantech
    echo IIS
    echo IIS Express
    echo Intel
    echo Internet Explorer
    echo JetBrains
    echo Microsoft
    echo Microsoft SQL Server
    echo Microsoft SQL Server Compact Edition
    echo Microsoft Visual Studio 11.0
    echo ModifiableWindowsApps
    echo MSBuild
    echo Oracle
    echo Realtek
    echo Reference Assemblies
    echo Uninstall Information
    echo Windows Defender
    echo Windows Defender Advanced Threat Protection
    echo Windows Mail
    echo Windows Media Player
    echo Windows Multimedia Platform
    echo Windows NT
    echo Windows Photo Viewer
    echo Windows Portable Devices
    echo Windows Security
    echo Windows Sidebar
    echo WindowsApps
    echo WindowsPowerShell
    ) > "exclusions\Program Files.txt"
)

if not exist "exclusions\Program Files (x86).txt" (
    (
    echo Application Verifier
    echo Common Files
    echo HTML Help Workshop
    echo IIS
    echo IIS Express
    echo Internet Explorer
    echo Microsoft
    echo Microsoft ASP.NET
    echo Microsoft Help Viewer
    echo Microsoft SDKs
    echo Microsoft SQL Server
    echo Microsoft SQL Server Compact Edition
    echo Microsoft Visual Studio 11.0
    echo Microsoft WCF Data Services
    echo Microsoft Web Tools
    echo Microsoft.NET
    echo MSBuild
    echo NuGet
    echo Reference Assemblies
    echo Windows Defender
    echo Windows Kits
    echo Windows Mail
    echo Windows Media Player
    echo Windows Multimedia Platform
    echo Windows NT
    echo Windows Photo Viewer
    echo Windows Portable Devices
    echo Windows Sidebar
    echo WindowsPowerShell
    echo ECULite
    echo SMS-Soft
    ) > "exclusions\Program Files (x86).txt"
)

if not exist "exclusions\Program Files (x86) Common Files.txt" (
    (
    echo Merge Modules
    echo Microsoft
    echo Microsoft Shared
    echo Services
    echo System
    ) > "exclusions\Program Files (x86) Common Files.txt"
)

if not exist "exclusions\ProgramData.txt" (
    (
    echo Intel
    echo Microsoft
    echo Oracle
    echo Package Cache
    echo Packages
    echo PreEmptive Solutions
    echo regid.1991-06.com.microsoft
    echo SoftwareDistribution
    echo ssh
    echo USOPrivate
    echo USOShared
    echo Windows App Certification Kit
    ) > "exclusions\ProgramData.txt"
)

if not exist "exclusions\Local.txt" (
    (
    echo Apps
    echo cache
    echo CEF
    echo Comms
    echo ConnectedDevicesPlatform
    echo CrashDumps
    echo CrashReportClient
    echo D3DSCache
    echo enchant
    echo fontconfig
    echo gegl-0.4
    echo GHISLER
    echo History
    echo Microsoft
    echo Package Cache
    echo Packages
    echo PeerDistRepub
    echo PlaceholderTileLogoFolder
    echo Publishers
    echo speech
    echo SquirrelTemp
    echo Temp
    echo Temporary Internet Files
    echo ToastNotificationManagerCompat
    ) > "exclusions\Local.txt"
)

if not exist "exclusions\LocalLow.txt" (
    (
    echo Intel
    echo Microsoft
    echo Temp
    ) > "exclusions\LocalLow.txt"
)

if not exist "exclusions\Roaming.txt" (
    (
    echo Adobe
    echo Electron
    echo GHISLER
    echo Microsoft
    echo tonfotos
    ) > "exclusions\Roaming.txt"
)

if not exist "exclusions\UserProfile_Folders.txt" (
    (
    echo AppData
    echo Application Data
    echo Cookies
    echo Local Settings
    echo NetHood
    echo PrintHood
    echo Recent
    echo SendTo
    echo Favorites
    echo Contacts
    echo 3D Objects
    echo Searches
    echo Saved Games
    echo Links
    ) > "exclusions\UserProfile_Folders.txt"
)

if not exist "exclusions\User_Files.txt" (
    (
    echo NTUSER.DAT
    echo ntuser.ini
    echo desktop.ini
    echo thumbs.db
    echo IconCache.db
    ) > "exclusions\User_Files.txt"
)

if not exist C:\ (
    echo ERROR: Drive C:\ not found!
    timeout /t 10
    exit /b 1
)

echo -- C:\ --
call :ProcessFolder "C:\" "Backup" "%exclusions_C%" "%XOPT%"

echo -- %ProgramFiles% --
call :ProcessFolder "%ProgramFiles%" "Backup\Program Files" "%exclusions_ProgramFiles%" "%XOPT%"

echo -- %ProgramFiles(x86)% --
call :ProcessFolder "%ProgramFiles(x86)%" "Backup\Program Files (x86)" "%exclusions_ProgramFiles_x86%" "%XOPT%"

echo -- %ProgramFiles(x86)%\Common Files --
call :ProcessFolder "%ProgramFiles(x86)%\Common Files" "Backup\Program Files (x86)\Common Files" "%exclusions_CommonFiles%" "%XOPT%"

echo -- C:\ProgramData --
call :ProcessFolder "C:\ProgramData" "Backup\ProgramData" "%exclusions_ProgramData%" "%XOPT%"

echo -- %LOCAL% --
call :ProcessFolder "C:\%LOCAL%" "Backup\%LOCAL%" "%exclusions_Local%" "%XOPT%"

echo -- %LOCALLOW% --
call :ProcessFolder "C:\%LOCALLOW%" "Backup\%LOCALLOW%" "%exclusions_LocalLow%" "%XOPT%"

echo -- %ROAMING% --
call :ProcessFolder "C:\%ROAMING%" "Backup\%ROAMING%" "%exclusions_Roaming%" "%XOPT%"

echo -- %USERPROFILE% --
call :ProcessFolder "%USERPROFILE%" "Backup\Users\%USERNAME%" "%exclusions_UserProfile_Folders%" "%XOPT%"

call :CopyFiles "%USERPROFILE%" "Backup\Users\%USERNAME%" "%exclusions_User_File%"
call :CopyFiles "%USERPROFILE%\AppData\Local" "Backup\%LOCAL%" "%exclusions_User_File%"

timeout /t 10
endlocal
exit /b

:ProcessFolder
setlocal
set "source=%~1"
set "dest=%~2"
set "exclusions_list=%~3"
set "xcopy_opts=%~4"

if not exist "%dest%" (
    mkdir "%dest%"
)

for /d %%F in ("%source%\*") do (
    set "folder=%%~nxF"
    
    findstr /i /x /c:"!folder!" "%exclusions_list%" >nul
    if errorlevel 1 (
        echo Copying: !folder!
        XCOPY "%%F\*.*" "%dest%\!folder!\" %xcopy_opts%
    )
)

endlocal
exit /b

:CopyFiles
setlocal
set "source=%~1"
set "dest=%~2"
set "exclusions_list=%~3"

if not exist "%dest%" (
    mkdir "%dest%"
)

for %%F in ("%source%\*") do (
    if not exist "%%F\" (
        set "filename=%%~nxF"

        findstr /i /x /c:"!filename!" "%exclusions_list%"
        if errorlevel 1 (
            echo Copying file: !filename!
            copy /Y "%%F" "%dest%\" >nul
        )
    )
)

endlocal
exit /b
