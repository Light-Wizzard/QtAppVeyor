Write-Host "build_script Windows QT path=$env:Path" -ForegroundColor Yellow
$env:MY_BUILD_GOOD = false
Set-Location -Path "$env:APPVEYOR_BUILD_FOLDER"
New-Item -Path $env:APPVEYOR_BUILD_FOLDER -Name "build" -ItemType Directory
Set-Location -Path 'build'
New-Item -Path $env:APPVEYOR_BUILD_FOLDER\build -Name "AppDir" -ItemType "directory"
$env:INSTALL_ROOT = 'AppDir'
$env:DESTDIR = 'AppDir'
$env:BUILD_ROOT = "$env:APPVEYOR_BUILD_FOLDER\build"
#$env:MY_MAKE = "qmake.exe $env:APPVEYOR_BUILD_FOLDER\$env:MY_BIN_PRO_RES_NAME.pro CONFIG+=$env:CONFIGURATION CONFIG+=x86_64"
#Invoke-Expression $env:MY_MAKE
$env:CMAKEGENERATOR = "MinGW Makefiles"
#$env:CMAKEGENERATOR = "NMake Makefiles"
#$env:CMAKEGENERATOR = "Visual Studio 16 2019"
#$env:CMAKEGENERATOR = "Unix Makefiles"
# 32 Bit only
# ! C:\msys64\mingw32\bin\i686-w64-mingw32-g++.exe
# C:\msys64\mingw64\bin\x86_64-w64-mingw32-g++.exe
#
$env:CC="C:\msys64\mingw64\bin\x86_64-w64-mingw32-gcc.exe"
$env:CXX="C:\msys64\mingw64\bin\x86_64-w64-mingw32-g++.exe"

# -DCMAKE_PREFIX_PATH="$env:CMAKE_PATH_PREFIX" $env:CMAKE_PATH_PREFIX = "C:\Qt\$env:MY_QT_VERSION\msvc$env:MY_VS_VERSION_64\lib\cmake"
#$env:MY_MAKE = "cmake -A x64 -G $env:CMAKEGENERATOR -DCMAKE_PREFIX_PATH=$env:CMAKE_PATH_PREFIX -DCMAKE_BUILD_TYPE=$env:CONFIGURATION -DCMAKE_INSTALL_PREFIX=AppDir .."
#cmd /c cmake -G "MinGW Makefiles" -DCMAKE_PREFIX_PATH="$env:CMAKE_PATH_PREFIX" -DCMAKE_INSTALL_PREFIX=AppDir -DCMAKE_C_COMPILER=/c/MinGW/bin/gcc.exe -DCMAKE_CXX_COMPILER=/c/MinGW/bin/g++.exe ..
cmd /c cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=AppDir ..
If ($?) {
    Write-Host "build_script Windows QT x64 cmake"
    Invoke-Expression "cmake --build . --config $env:CONFIGURATION --target install"
    If ($?) {
        Test-Path -Path AppDir\$env:MY_BIN_PRO_RES_NAME.exe -PathType Leaf
        If ($?) {
            $env:MY_BUILD_GOOD = true
        }
    }
}

If ($env:MY_BUILD_GOOD -eq "true") {
    $currentDirectory = [System.AppDomain]::CurrentDomain.BaseDirectory.TrimEnd('\')
    If ($currentDirectory -eq $PSHOME.TrimEnd('\')) {
        $currentDirectory = $PSScriptRoot
    }
    Write-Host "After Windows build $env:currentDirectory" -ForegroundColor DarkGreen
    Get-ChildItem -Path AppDir
    Copy-Item "C:\Qt\Tools\QtCreator\bin\plugins\platforms\*" -Destination "AppDir" -Recurse
    Invoke-Expression "windeployqt AppDir\$env:MY_BIN_PRO_RES_NAME.exe --verbose=2"
    Invoke-Expression "7z a -tzip $env:MY_BIN_PRO_RES_NAME-$env:MY_OS-$env:CONFIGURATION-$env:PLATFORM.zip AppDir -r"
    Copy-Item "$env:APPVEYOR_BUILD_FOLDER\build\$env:MY_BIN_PRO_RES_NAME-$env:MY_OS-$env:CONFIGURATION-$env:PLATFORM.zip" -Destination "$env:APPVEYOR_BUILD_FOLDER\"
    Copy-Item "*.zip" -Destination "$env:APPVEYOR_BUILD_FOLDER\"
    Set-Location -Path $env:APPVEYOR_BUILD_FOLDER
    Write-Host "Completed-Build Windows" -ForegroundColor DarkGreen
}
