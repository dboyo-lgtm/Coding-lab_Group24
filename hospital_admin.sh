#!/bin/bash

initialize_system() {
    echo "=============================================="
    echo "Initializing KNH System Environment..."
    echo "=============================================="

    # List of required directories
    local directories=("active_logs" "archived_logs" "reports")

    for dir in "${directories[@]}"; do
        if [ -d "$dir" ]; then
            echo "[OK] '$dir' directory already exists. Skipping."
        else
            echo "Creating $dir directory..."
            mkdir -p "$dir"
            echo "[DONE] '$dir' created successfully."
        fi
    done

    echo "----------------------------------------------"
    echo "Directory initialization complete."
}

# =============================================================
# Member 2 - The Security Lead
# Function: secure_data()
# Purpose: Lock down active_logs so only the owner can read/write
# =============================================================

secure_data() {
    echo ""
    echo "=== [SECURITY LEAD] Applying Security Permissions ==="

    # Target directory
    TARGET_DIR="active_logs"

    # Check that the directory exists before trying to secure it
    if [ ! -d "$TARGET_DIR" ]; then
        echo "[ERROR] '$TARGET_DIR' does not exist. Run initialize_system() first."
        return 1
    fi

    echo "[*] Securing '$TARGET_DIR' directory..."

    # chmod 600 on files: owner read+write only (no group, no others)
    # chmod 700 on directory: owner can enter and list; group/others locked out
    chmod 700 "$TARGET_DIR"
    chmod 600 "$TARGET_DIR"/*.log 2>/dev/null  # applies if log files already exist

    echo "[✓] Permissions applied:"
    echo "    - Directory '$TARGET_DIR': 700 (owner rwx only)"
    echo "    - Log files inside:        600 (owner rw only)"
    echo ""

    # Display the resulting permissions so the user can verify
    echo "[*] Current permission snapshot (ls -l):"
    ls -ld "$TARGET_DIR"
    ls -l "$TARGET_DIR" 2>/dev/null || echo "    (No files yet inside active_logs)"

    echo ""
    echo "[✓] active_logs is now secured. No group or public access."
}

initialize_system
