@echo off
cd /d %~dp0

:: Clean old results
if exist results rmdir /s /q results
mkdir results

echo Starting Robot Framework tests...
echo Current directory: %CD%

:: Run the correct test file
"C:\Users\somalaraju.nithesh\AppData\Local\Programs\Python\Python313\Scripts\robot.exe" -d results abc.robot

:: Ensure WORKSPACE path is available
if "%WORKSPACE%"=="" (
   set WORKSPACE=C:\ProgramData\Jenkins\.jenkins\workspace\Demo
)

:: Copy results to Jenkins workspace
xcopy /Y /E results "%WORKSPACE%\results"

set EXIT_CODE=%ERRORLEVEL%
echo Test completed with exit code: %EXIT_CODE%
exit /b %EXIT_CODE%
