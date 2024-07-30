@echo off

mkdir ..\..\Miatoll-Drivers-Release
del ..\..\Miatoll-Drivers-Release\Miatoll-Drivers-Full.7z

mkdir Miatoll-Drivers-Full
mkdir Miatoll-Drivers-Full\components
mkdir Miatoll-Drivers-Full\definitions
xcopy /cheriky ..\components\ANYSOC Miatoll-Drivers-Full\components\ANYSOC
xcopy /cheriky ..\components\QC7125 Miatoll-Drivers-Full\components\QC7125
xcopy /cheriky ..\definitions\Desktop Miatoll-Drivers-Full\definitions\Desktop

"7z.exe" a -t7z -r ..\..\Miatoll-Drivers-Release\Miatoll-Drivers-Full.7z Miatoll-Drivers-Full\*

rmdir /Q /S Miatoll-Drivers-Full