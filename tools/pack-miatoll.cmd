@echo off

mkdir ..\..\Miatoll-Drivers-Release
del ..\..\Miatoll-Drivers-Release\Miatoll-Drivers.zip

echo @echo off > ..\OnlineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> ..\OnlineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> ..\OnlineUpdater.cmd
echo .\tools\DriverUpdater\%%PROCESSOR_ARCHITECTURE%%\DriverUpdater.exe -r . -d .\definitions\Desktop\ARM64\Internal\miatoll.xml >> ..\OnlineUpdater.cmd
echo pause >> ..\OnlineUpdater.cmd

echo @echo off > ..\OfflineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> ..\OfflineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> ..\OfflineUpdater.cmd
echo set /P DrivePath=Enter Drive letter ^^^(with the colon!^^^) of the connected device in mass storage mode ^^^(e.g. X:^^^): >> ..\OfflineUpdater.cmd
echo if not "%%DrivePath:~1,1%%"==":" set DrivePath=%%DrivePath%%: >> ..\OfflineUpdater.cmd
echo .\tools\DriverUpdater\%%PROCESSOR_ARCHITECTURE%%\DriverUpdater.exe -r . -d .\definitions\Desktop\ARM64\Internal\miatoll.xml -p %%DrivePath%% >> ..\OfflineUpdater.cmd
echo pause >> ..\OfflineUpdater.cmd

echo apps\IPA > filelist_miatoll.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.BASE >> filelist_miatoll.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_COMPONENTS >> filelist_miatoll.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_RIL >> filelist_miatoll.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_RIL_EXTRAS >> filelist_miatoll.txt
echo components\QC7125\Device\DEVICE.SOC_QC7125.MIATOLL >> filelist_miatoll.txt
echo components\QC7125\Device\DEVICE.SOC_QC7125.MIATOLL_MINIMAL >> filelist_miatoll.txt
echo components\QC7125\GRAPHICS\GRAPHICS.SOC_QC7125.MIATOLL_DESKTOP >> filelist_miatoll.txt
echo components\QC7125\Platform\PLATFORM.SOC_QC7125.BASE >> filelist_miatoll.txt
echo components\QC7125\Platform\PLATFORM.SOC_QC7125.BASE_MINIMAL >> filelist_miatoll.txt
echo definitions\Desktop\ARM64\Internal\miatoll.xml >> filelist_miatoll.txt
echo tools\DriverUpdater >> filelist_miatoll.txt
echo OfflineUpdater.cmd >> filelist_miatoll.txt
echo OnlineUpdater.cmd >> filelist_miatoll.txt
echo README.md >> filelist_miatoll.txt

cd ..
"%ProgramFiles%\7-zip\7z.exe" a -tzip ..\Miatoll-Drivers-Release\Miatoll-Drivers.zip @tools\filelist_miatoll.txt -scsWIN
cd tools

del ..\OfflineUpdater.cmd
del ..\OnlineUpdater.cmd
del filelist_miatoll.txt