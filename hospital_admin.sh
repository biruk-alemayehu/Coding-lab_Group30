#!/bin/bash

initialize_system() {
    directories=("active_logs" "archived_logs" "reports")

    for dir in "#{directories[@]}"; do
        if [ ! -d "$dir"  ]; then
             echo "Creating the directory.."
             mkdir "$dir"
        fi
    done
}
