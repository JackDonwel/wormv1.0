Worm Propagator Batch Script (worm_propagator.bat)

Version: 1.1 (Improved Version)
Author: Donwell
Purpose: Educational Self-Propagation Script
Overview

This batch script (worm_propagator.bat) is designed to propagate itself and an accompanying helper executable (EnhancedCleanup.exe) across all accessible drives on a Windows machine, excluding the drive where the script is currently running. For each target drive, it copies:

    The worm script itself (worm.bat)

    A helper executable (EnhancedCleanup.exe), if present

    An autorun.inf file configured to automatically execute the worm script when the drive is accessed

Features

    Enumerates all logical drives on the system (except the source drive).

    Skips drives that are inaccessible or already contain an autorun.inf file (to avoid overwriting or redundant actions).

    Copies the worm script and helper executable (if available) to each target drive.

    Creates an autorun.inf file that launches the worm script automatically when the drive is accessed.

    Provides detailed console output to track progress, success, and errors for each drive.

Important Notes

    Educational Use Only: This script is intended purely for educational purposes, such as demonstrating self-replication and autorun file mechanics.

    Ethical Responsibility: Never use this script maliciously or without explicit permission on any system. Unauthorized propagation or execution can cause harm, legal issues, and data loss.

    Helper Executable: The script attempts to copy EnhancedCleanup.exe if it exists in the same directory. If missing, propagation continues but some intended functionality might be limited.

    Permissions: Running this script may require administrative privileges depending on the drives' access policies. Failure to copy files may result from read-only drives or insufficient permissions.

    Autorun.inf Behavior: Many modern Windows versions restrict or disable autorun execution from removable drives for security reasons. This script demonstrates the technique but actual autorun execution might be blocked by OS protections.

Usage

    Place worm_propagator.bat and the optional EnhancedCleanup.exe helper executable in the same folder.

    Run the script from the command prompt (preferably with administrator privileges for full effect).

    Observe the console output for propagation status and errors.

    Check target drives for copied files and autorun.inf.

Script Variables (for customization)
Variable	Description	Default Value
WORM_FILENAME	Name of the worm script to copy and run	worm.bat
HELPER_EXE_FILENAME	Name of the helper executable file	EnhancedCleanup.exe
AUTORUN_FILENAME	Autorun configuration filename	autorun.inf

You may rename these variables and corresponding files as needed, but ensure consistency for proper operation.
Disclaimer

This script is provided "as-is" for learning and experimentation. The author is not responsible for any damage, data loss, or legal consequences arising from misuse or unauthorized execution.
