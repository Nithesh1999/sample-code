@echo off
cd /d %~dp0

:: Clean old results
if exist results rmdir /s /q results
mkdir results

echo Starting Robot Framework tests...
echo Current directory: %CD%

:: Check if abc.robot exists
if not exist abc.robot (
    echo ERROR: abc.robot not found in %CD%
    exit /b 1
)

:: Check if the virtual environment exists
if not exist venv\Scripts\activate.bat (
    echo ERROR: Virtual environment not found. Please create the virtual environment first.
    exit /b 1
)

:: Activate the virtual environment
call venv\Scripts\activate.bat

:: Run the test with the virtual environment's robot.exe
robot -d results abc.robot

:: Ensure WORKSPACE path is available
if "%WORKSPACE%"=="" (
   set WORKSPACE=C:\ProgramData\Jenkins\.jenkins\workspace\Demo
)

:: Copy results if present
if exist results (
    xcopy /Y /E results "%WORKSPACE%\results"
) else (
    echo WARNING: Results directory missing or empty
)

set EXIT_CODE=%ERRORLEVEL%
echo Test completed with exit code: %EXIT_CODE%
exit /b %EXIT_CODE%
