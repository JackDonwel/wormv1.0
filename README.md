# Worm Propagation Script - Educational Tool

```markdown
# Worm Propagation Simulation Script

![Batch Script](https://img.shields.io/badge/language-Batch-blue)
![Educational Use](https://img.shields.io/badge/purpose-educational-green)
![Version](https://img.shields.io/badge/version-1.1-orange)

## 📌 Overview
This batch script simulates worm-like propagation behavior for educational purposes only. It demonstrates how malware might spread through removable drives by:
- Copying itself to target drives
- Creating autorun.inf files for automatic execution
- Propagating a helper executable (if available)

**Important:** This script is designed for cybersecurity education and research. Never deploy it on live systems without explicit permission.

## ⚠️ Legal & Ethical Notice
```plaintext
THIS SOFTWARE IS PROVIDED "AS IS" FOR EDUCATIONAL PURPOSES ONLY. 
THE AUTHOR DISCLAIMS ALL RESPONSIBILITY FOR ILLEGAL OR UNETHICAL USE. 
UNAUTHORIZED DEPLOYMENT MAY VIOLATE LOCAL AND INTERNATIONAL LAWS.

Use only in controlled environments with proper authorization.
```

## 🛠 Prerequisites
1. Windows operating system
2. Command Prompt/PowerShell access
3. Removable drives for testing (USB drives recommended)
4. Helper executable (Optional: `EnhancedCleanup.exe`)

## 📂 File Structure
```
worm_propagator.bat      # Main propagation script
EnhancedCleanup.exe      # Optional helper executable (not included)
README.md                # This documentation
```

## 🔧 How It Works

### Core Functionality
1. **Self-Propagation**:
   - Detects all available drives
   - Copies itself to removable drives
   - Skips the source drive to prevent recursion

2. **Autorun Creation**:
   - Generates `autorun.inf` files
   - Configures autorun to execute the script when drive is accessed

3. **Helper Deployment**:
   - Copies `EnhancedCleanup.exe` if present in source directory
   - Sets executable as drive icon

### Key Features
- Drive accessibility checks
- Existing autorun detection
- Error handling for read-only drives
- Detailed progress reporting
- Skip logic for current drive

## 🚀 Usage Instructions

1. **Basic Execution**:
   ```cmd
   worm.bat
   ```

2. **Configuration Options**:
   - Modify these variables at the top of the script:
     ```bat
     set "WORM_FILENAME=worm.bat"
     set "HELPER_EXE_FILENAME=EnhancedCleanup.exe"
     set "AUTORUN_FILENAME=autorun.inf"
     ```

3. **Expected Output**:
   ```
   [*] Initializing Propagation Script...
   [*] Script Name: worm.bat
   [*] Running from Drive: C:
   [*] Helper Executable: EnhancedCleanup.exe
   ...
   [+] Successfully copied "worm.bat" to E:
   [+] Creating "autorun.inf" on E:
   ```

## ⚠️ Limitations & Notes
- Requires write access to target drives
- Modern Windows versions often disable autorun by default
- Antivirus software may detect/block execution
- Helper executable (`EnhancedCleanup.exe`) must be provided separately
- Script will skip drives with existing autorun.inf files

## 🔒 Safety Precautions
1. Only run in virtual machines or isolated environments
2. Disable network connectivity during testing
3. Remove all production drives before execution
4. Monitor with antivirus software
5. Delete created files immediately after testing

## 📜 License
Educational Use Only - No redistribution permitted. All use assumes acceptance of liability by the user.

---

**Created by Donwell | Version 1.1 | For Educational Purposes Only**
```

## Recommended Folder Structure
```
/worm_propagation_simulation/
├── worm_propagator.bat       # Main script
├── EnhancedCleanup.exe       # Optional helper (not included)
└── README.md                 # This documentation
```

This README provides comprehensive documentation while emphasizing the educational nature of the script and including critical warnings about responsible usage. The structure covers functionality, usage instructions, and important safety considerations.
