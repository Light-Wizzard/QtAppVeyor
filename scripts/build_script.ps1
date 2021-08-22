$env:MY_BUILD_GOOD = false
If ($env:PLATFORM -eq "x64" -And $env:MY_COMPILER -eq "Qt") {
    Write-Host "build_script Windows QT x64 path=$env:Path" -ForegroundColor Yellow
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
    $env:CMAKE_PATH_PREFIX = "C:\Qt\$env:MY_QT_VERSION\msvc$env:MY_VS_VERSION_64\lib\cmake"
    $env:MY_MAKE = "cmake -A x64 -G $env:CMAKEGENERATOR -DCMAKE_PREFIX_PATH=$env:CMAKE_PATH_PREFIX -DCMAKE_BUILD_TYPE=$env:CONFIGURATION CONFIG+=x86_64 -DCMAKE_INSTALL_PREFIX=AppDir .."
    Write-Host "qmake dbug: $env:MY_MAKE"
    Invoke-Expression cmake -DCMAKE_INSTALL_PREFIX=AppDir ..
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
}
ElseIf ($env:PLATFORM -eq "x86" -And $env:MY_COMPILER -eq "Qt") {
    Write-Host "build_script Windows QT x86 path=$env:Path" -ForegroundColor Magenta
    Set-Location -Path $env:APPVEYOR_BUILD_FOLDER
    New-Item -Path 'build' -ItemType Directory
    Set-Location -Path build
    $env:INSTALL_ROOT = 'AppDir'
    $env:DESTDIR = 'AppDir'
    $env:BUILD_ROOT = "$env:APPVEYOR_BUILD_FOLDER\build"
    $env:MY_MAKE = "qmake.exe $env:APPVEYOR_BUILD_FOLDER\$env:MY_BIN_PRO_RES_NAME.pro CONFIG+=$env:CONFIGURATION CONFIG+=x86"
    Write-Host "qmake dbug: $env:MY_MAKE"
    Invoke-Expression $env:MY_MAKE
    If ($?) {
        Write-Host "build_script Windows QT x64 mingw32-make"
        Invoke-Expression "mingw32-make.exe"
        If ($?) {
            Write-Host "build_script Windows QT x64 mingw32-make install"
            Invoke-Expression "mingw32-make.exe install"
            If ($?) {
                Test-Path -Path AppDir\$env:MY_BIN_PRO_RES_NAME.exe -PathType Leaf
                If ($?) {
                    $env:MY_BUILD_GOOD = true
                }
            }
        }
    }
}
ElseIf ($env:PLATFORM -eq "x64" -And $env:MY_COMPILER -eq "Vs") {
    Write-Host "build_script Windows VS x64 path=$env:Path" -ForegroundColor DarkYellow
    Set-Location -Path $env:APPVEYOR_BUILD_FOLDER
    New-Item -Path 'build' -ItemType Directory
    Set-Location -Path build
    $env:INSTALL_ROOT=AppDir
    $env:BUILD_ROOT = "$env:APPVEYOR_BUILD_FOLDER\build"
    $env:MY_QT_MAKE="qmake $env:APPVEYOR_BUILD_FOLDER%\$env:MY_BIN_PRO_RES_NAME.pro CONFIG+=$env:CONFIGURATION CONFIG+=x86_64"
    Invoke-Expression $env:MY_QT_MAKE
    If ($?) {
        Write-Host "build_script Windows VS x64 mmake"
        Invoke-Expression "mmake"
        If ($?) {
            Write-Host "build_script Windows VS x64 mmake install INSTALL_ROOT=AppDir"
            Invoke-Expression "mmake install INSTALL_ROOT=AppDir"
            If ($?) {
                Test-Path -Path AppDir\$env:MY_BIN_PRO_RES_NAME.exe -PathType Leaf
                If ($?) {
                    $env:MY_BUILD_GOOD = true
                }
            }
        }
    }
}
ElseIf ($env:PLATFORM -eq "x86" -And $env:MY_COMPILER -eq "Vs") {
    Write-Host "build_script Windows VS x86 path=$env:Path" -ForegroundColor DarkMagenta
    Set-Location -Path $env:APPVEYOR_BUILD_FOLDER
    New-Item -Path 'build' -ItemType Directory
    Set-Location -Path build
    $env:INSTALL_ROOT=AppDir
    $env:BUILD_ROOT = "$env:APPVEYOR_BUILD_FOLDER\build"
    $env:MY_QT_MAKE="qmake -spec win32-g++ $env:APPVEYOR_BUILD_FOLDER\$env:MY_BIN_PRO_RES_NAME.pro CONFIG+=$env:CONFIGURATION CONFIG+=x86"
    Invoke-Expression $env:MY_QT_MAKE
    If ($?) {
        Write-Host "build_script Windows VS x86 mmake"
        Invoke-Expression "mmake"
        If ($?) {
            Write-Host "build_script Windows VS x86 mmake install INSTALL_ROOT=AppDir"
            Invoke-Expression "mmake install INSTALL_ROOT=AppDir"
            If ($?) {
                Test-Path -Path AppDir\$env:MY_BIN_PRO_RES_NAME.exe -PathType Leaf
                If ($?) {
                    $env:MY_BUILD_GOOD = true
                }
            }
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
