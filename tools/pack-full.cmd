@echo off

mkdir ..\..\Miatoll-Drivers-Release
del ..\..\Miatoll-Drivers-Release\Miatoll-Drivers-Full.zip

mkdir Miatoll-Drivers-Full
mkdir Miatoll-Drivers-Full\components
mkdir Miatoll-Drivers-Full\definitions
xcopy /cheriky ..\components\ANYSOC Miatoll-Drivers-Full\components\ANYSOC
xcopy /cheriky ..\components\QC7125 Miatoll-Drivers-Full\components\QC7125
xcopy /cheriky ..\definitions\Desktop Miatoll-Drivers-Full\definitions\Desktop

"%ProgramFiles%\7-zip\7z.exe" a -tzip -r ..\..\Miatoll-Drivers-Release\Miatoll-Drivers-Full.zip Miatoll-Drivers-Full\*

rmdir /Q /S Miatoll-Drivers-Full