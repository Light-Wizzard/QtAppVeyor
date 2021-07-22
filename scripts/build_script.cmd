echo "build_script Windows"
# 
cd %APPVEYOR_BUILD_FOLDER% 
mkdir build 
cd build 
mkdir AppDir 
# FIXME
if %PLATFORM%==x86 qmake -v && qmake ..\%BIN_PRO_RES_NAME%.pro CONFIG+=%configuration% CONFIG+=c++11 DESTDIR=%cd% && mingw32-make && mingw32-make install INSTALL_ROOT=AppDir
if %PLATFORM%==x64 qmake -v && qmake ..\%BIN_PRO_RES_NAME%.pro CONFIG+=%configuration% CONFIG+=c++11 DESTDIR=%cd% && mingw32-make && mingw32-make install INSTALL_ROOT=AppDir
echo "after_build Windows"
dir 
#
copy "%APPVEYOR_BUILD_FOLDER%\build\%BIN_PRO_RES_NAME%.exe" "AppDir\%BIN_PRO_RES_NAME%-%MY_OS%-%CONFIGURATION%-%PLATFORM%.exe"
#
windeployqt "AppDir/%BIN_PRO_RES_NAME%.exe" --verbose=2
#
mv %BIN_PRO_RES_NAME%.exe %BIN_PRO_RES_NAME%-%PLATFORM%.exe
#
# The packages/${QIF_PACKAGE_URI}/meta/installscript.qs creates this: cp -v "desktop/${BIN_PRO_RES_NAME}.desktop" "${QIF_PACKAGE_URI}";
cp -v "${APPVEYOR_BUILD_FOLDER}/desktop/${BIN_PRO_RES_NAME}.png" "${APPVEYOR_BUILD_FOLDER}/${QIF_PACKAGE_URI}/data";
cp -v "${APPVEYOR_BUILD_FOLDER}/desktop/${BIN_PRO_RES_NAME}.svg" "${APPVEYOR_BUILD_FOLDER}/${QIF_PACKAGE_URI}/data";
cp -v "${APPVEYOR_BUILD_FOLDER}/desktop/${BIN_PRO_RES_NAME}.ico" "${APPVEYOR_BUILD_FOLDER}/${QIF_PACKAGE_URI}/data";
rsync -Ravr "${APPVEYOR_BUILD_FOLDER}/usr/share/icons" "${APPVEYOR_BUILD_FOLDER}/${QIF_PACKAGE_URI}/icons";
ls "${APPVEYOR_BUILD_FOLDER}/${QIF_PACKAGE_URI}/data";
#
echo "Running Qt Installer Framework";

if %PLATFORM%==x64
{
    export ARTIFACT_APPIMAGE="${BIN_PRO_RES_NAME}-x64.exe";
}
else
{
    export ARTIFACT_APPIMAGE="${BIN_PRO_RES_NAME}-x86.exe";
}
#
export ARTIFACT_QIF="${BIN_PRO_RES_NAME}-Linux-Installer";
#
#for %%I in (%PRJLIBS%) do copy %PRJLIBDIR%\%%I AppDir\
7z a -tzip "%BIN_PRO_RES_NAME%-%MY_OS%-%CONFIGURATION%-%PLATFORM%.zip" AppDir -r
copy "%APPVEYOR_BUILD_FOLDER%\build\%BIN_PRO_RES_NAME%-%MY_OS%-%CONFIGURATION%-%PLATFORM%.zip" "%APPVEYOR_BUILD_FOLDER%\
echo APPVEYOR_BUILD_FOLDER=%APPVEYOR_BUILD_FOLDER% 
#
#xcopy /s /e /f "%APPVEYOR_BUILD_FOLDER%\build\AppDir" "%APPVEYOR_BUILD_FOLDER%\%QIF_PACKAGE_URI%"
./QtInstallerFramework-windows-x86-4.1.1.exe --offline-only -c "%APPVEYOR_BUILD_FOLDER%\config\config.xml" -p "%APPVEYOR_BUILD_FOLDER%\packages" "%BIN_PRO_RES_NAME%-Windows-Installer.exe"
7z a -tzip "%BIN_PRO_RES_NAME%-Windows-Installer.zip" "%BIN_PRO_RES_NAME%-Windows-Installer.exe"
#
C:\Qt\Tools\QtInstallerFramework\binarycreator.exe --offline-only -c "%APPVEYOR_BUILD_FOLDER%\config\config.xml" -p "%APPVEYOR_BUILD_FOLDER%\packages" "%BIN_PRO_RES_NAME%-Windows-Installer.exe"
copy *.zip %APPVEYOR_BUILD_FOLDER% 
copy *.exe %APPVEYOR_BUILD_FOLDER%
cd %APPVEYOR_BUILD_FOLDER% 

#
echo Current Path is %cd% 
dir 
echo -e "Completed-Build Windows"
