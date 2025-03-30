#!/bin/bash
# Start script for Render

# Debug: Print current directory
echo "Current directory: $(pwd)"
echo "Listing directory contents:"
ls -la

# Make sure required directories exist
mkdir -p ./data
mkdir -p ./cogs

# Debug: Check if cogs directory now exists
echo "After mkdir, checking cogs directory:"
ls -la ./cogs || echo "Failed to list cogs directory"

# If cogs directory is empty, try to copy from src directory
if [ -d "/opt/render/project/src/cogs" ] && [ ! "$(ls -A ./cogs)" ]; then
  echo "Cogs directory is empty, copying from src directory..."
  cp -r /opt/render/project/src/cogs/* ./cogs/
  echo "After copying, cogs directory contains:"
  ls -la ./cogs
fi

# Run environment check script
echo "Running environment check script..."
python check_environment.py

# Run the bot with proper error output
echo "Starting bot..."
python main.py 2>&1 | tee bot_error.log 