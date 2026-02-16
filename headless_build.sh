#!/bin/bash
# Headless build script for STM32CubeIDE project: Cam-to-Eth

# Path to STM32CubeIDE executable on macOS
IDE_PATH="/Applications/STM32CubeIDE.app/Contents/MacOS/stm32cubeide"

# Project Name (from .project file)
PROJECT_NAME="Cam-to-Eth"
BUILD_CONFIG="Debug"

# Create a temporary workspace directory
WORKSPACE_DIR=$(mktemp -d)
echo "Using temporary workspace: $WORKSPACE_DIR"

# Run the headless build
# -data: Location of the workspace
# -import: Location of the project to import (current directory)
# -build: ProjectName/ConfigurationName
# -cleanBuild: Optional, forces a clean build
echo "Starting build for $PROJECT_NAME ($BUILD_CONFIG)..."
"$IDE_PATH" --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data "$WORKSPACE_DIR" -import "$(pwd)" -cleanBuild "$PROJECT_NAME/$BUILD_CONFIG"

# Check exit code
EXIT_CODE=$?
if [ $EXIT_CODE -eq 0 ]; then
    echo "Build successful!"
else
    echo "Build failed with exit code $EXIT_CODE"
fi

# Clean up workspace
rm -rf "$WORKSPACE_DIR"

exit $EXIT_CODE
