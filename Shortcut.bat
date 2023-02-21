@echo off
set SCRIPT_DIR=%~dp0
set SHORTCUT_NAME=Parent Batch File.lnk
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

echo Creating shortcut to Parent Batch File in Startup folder...
echo Shortcut name: %SHORTCUT_NAME%
echo Startup folder: %STARTUP_FOLDER%

set SHORTCUT_TARGET="%SCRIPT_DIR%parent.bat"
set SHORTCUT_LOCATION="%STARTUP_FOLDER%\%SHORTCUT_NAME%"
set SHORTCUT_ARGUMENTS=

echo Shortcut target: %SHORTCUT_TARGET%
echo Shortcut location: %SHORTCUT_LOCATION%

echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut.vbs"
echo Set objShortcut = objShell.CreateShortcut(%SHORTCUT_LOCATION%) >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.TargetPath = %SHORTCUT_TARGET% >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.Arguments = %SHORTCUT_ARGUMENTS% >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.IconLocation = %SHORTCUT_TARGET% >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut.vbs"
cscript /nologo "%TEMP%\CreateShortcut.vbs"
del "%TEMP%\CreateShortcut.vbs"

echo Shortcut created successfully.
pause
