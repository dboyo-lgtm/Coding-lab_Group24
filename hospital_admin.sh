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

