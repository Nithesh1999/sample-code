@echo off
cd /d %~dp0

:: Ensure we're in the right directory
echo Running from directory: %CD%

:: Check if test file exists
if not exist abc.robot (
    echo ERROR: abc.robot not found.
    exit /b 1
)

:: Activate venv and run the test
call venv\Scripts\activate.bat
robot -d results abc.robot

:: Save test result exit code
set EXIT_CODE=%ERRORLEVEL%

:: Copy results to Jenkins workspace
if defined WORKSPACE (
    xcopy /Y /E results "%WORKSPACE%\results"
)

exit /b %EXIT_CODE%
