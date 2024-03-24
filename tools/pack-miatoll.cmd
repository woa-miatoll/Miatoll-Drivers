@echo off


      SET HOUR=%time:~0,2%
      SET dtStamp9=%date:~-2%%date:~4,2%%date:~7,2%-0%time:~1,1%%time:~3,2%
      SET dtStamp24=%date:~-2%%date:~4,2%%date:~7,2%-%time:~0,2%%time:~3,2%

      if "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) else (SET dtStamp=%dtStamp24%)


title [220X.%dtStamp%.prerelease] [Build preparation] [Packing Binaries]
REM rmdir /Q /S ..\..\miatoll-Drivers-Release
REM mkdir ..\..\miatoll-Drivers-Release

mkdir miatoll-Drivers-Full
mkdir miatoll-Drivers-Full\components
mkdir miatoll-Drivers-Full\definitions
xcopy /cheriky ..\components\QC7125 miatoll-Drivers-Full\components\QC7125
xcopy /cheriky ..\components\ANYSOC miatoll-Drivers-Full\components\ANYSOC
xcopy /cheriky ..\definitions\Desktop miatoll-Drivers-Full\definitions\Desktop

copy .\DriverUpdater.ARM64.exe miatoll-Drivers-Full
copy .\DriverUpdater.AMD64.exe miatoll-Drivers-Full
copy .\DriverUpdater.X86.exe miatoll-Drivers-Full

echo @echo off > miatoll-Drivers-Full\OnlineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> miatoll-Drivers-Full\OnlineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> miatoll-Drivers-Full\OnlineUpdater.cmd
echo DriverUpdater.%%PROCESSOR_ARCHITECTURE%%.exe -r . -d .\definitions\Desktop\ARM64\Internal\miatoll.xml >> miatoll-Drivers-Full\OnlineUpdater.cmd
echo pause >> miatoll-Drivers-Full\OnlineUpdater.cmd

echo @echo off > miatoll-Drivers-Full\OfflineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> miatoll-Drivers-Full\OfflineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> miatoll-Drivers-Full\OfflineUpdater.cmd
echo set /P DrivePath=Enter Drive letter ^^^(with the colon!^^^) of the connected device in mass storage mode ^^^(e.g. D:^^^): >> miatoll-Drivers-Full\OfflineUpdater.cmd
echo DriverUpdater.%%PROCESSOR_ARCHITECTURE%%.exe -r . -d .\definitions\Desktop\ARM64\Internal\miatoll.xml -p %%DrivePath%% >> miatoll-Drivers-Full\OfflineUpdater.cmd
echo pause >> miatoll-Drivers-Full\OfflineUpdater.cmd

"%ProgramFiles%\7-zip\7z.exe" a -tzip -r ..\..\miatoll-Drivers-Release\miatoll-Drivers-Full.zip miatoll-Drivers-Full\*

REM move miatoll-Drivers-Full\components\QC7125 ..\components\QC7125
REM move miatoll-Drivers-Full\definitions\Desktop ..\definitions

rmdir /Q /S miatoll-Drivers-Full