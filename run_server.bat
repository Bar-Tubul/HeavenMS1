@echo off
call build.bat
if %ERRORLEVEL% neq 0 exit /b 1
call launch.bat 