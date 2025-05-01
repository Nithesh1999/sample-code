@echo off
cd /d %~dp0

if not exist results mkdir results

echo Starting Robot Framework tests...
echo Current directory: %CD%

:: Call robot directly by full path
"C:\Users\somalaraju.nithesh\AppData\Local\Programs\Python\Python313\Scripts\robot.exe" -d results *.robot

:: Copy results to Jenkins workspace
xcopy /Y /E results "%WORKSPACE%\results"

set EXIT_CODE=%ERRORLEVEL%
echo Test completed with exit code: %EXIT_CODE%
exit /b %EXIT_CODE%
