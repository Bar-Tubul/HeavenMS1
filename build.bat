@echo off
setlocal enabledelayedexpansion

REM Set source, output, and library directories
set SRC=src
set DIST=dist
set CORES=cores\*

REM Create dist directory if it doesn't exist
if not exist %DIST% mkdir %DIST%

REM Collect all Java files into a temporary file list
(for /R %SRC% %%f in (*.java) do @echo %%f) > sources.txt

REM Compile all Java files
javac -d %DIST% -cp "%CORES%" @sources.txt
if %ERRORLEVEL% neq 0 (
    echo Build failed. See errors above.
    del sources.txt
    exit /b 1
)

del sources.txt
echo Build complete.
endlocal 