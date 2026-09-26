#!/bin/bash

initialize_system() {
    directories=("active_logs" "archived_logs" "reports")

    for dir in "${directories[@]}"; do
        if [ ! -d "$dir"  ]; then
             echo "Creating $dir directory.."
             mkdir "$dir"
             echo "$dir directory created"
        else
             echo "$dir directory already exists"
        fi
    done

    echo "System initialization completed"
}


initialize_system

Secure_data() {
	echo "Securing active_logs directory (owner-only access)..."
		chmod 700 active_logs
	echo "updated permisions for active_logs:"
		ls -l active_logs
