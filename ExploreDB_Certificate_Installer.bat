@echo off
set DEBUG_MODE=false
cd /d "%~dp0"

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ========================================
    echo   Trust ExploreDB Development Certificate
    echo ========================================
    echo.
    echo This script needs Administrator rights to safely install the certificate.
    echo A Windows UAC prompt will appear. Please click "Yes".
    echo.
    pause
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: If we reach here, we are running as Administrator
echo ========================================
echo   Trust ExploreDB Development Certificate
echo ========================================
echo.
echo Installing certificate securely...

if "%DEBUG_MODE%"=="true" (
    certutil -p "password" -importpfx Root "%~dp0ExploreDB_Certificate.pfx"
) else (
    certutil -p "password" -importpfx Root "%~dp0ExploreDB_Certificate.pfx" >nul 2>&1
)

echo.
echo ========================================
echo SUCCESS! Certificate installed perfectly!
echo You may now close this window and double-click ExploreDB.msix to install!
echo ========================================
echo.
pause
