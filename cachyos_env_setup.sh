#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== 1. Updating System & Installing Gaming/Audio Dependencies ==="
# Installing base tools, Nim, VS Code, graphics, GameMode, and PipeWire development packages
sudo pacman -Syu --needed --noconfirm \
    base-devel git curl nim nimble visual-studio-code-bin \
    alsa-lib libx11 libxrandr libxi libxcursor libxinerama mesa \
    gamemode pipewire-audio pipewire-jack libpulse

echo "=== 2. Optimizing User Groups for Pro-Audio (Realtime) ==="
# Realtime privileges are handled by the 'realtime' or 'audio' group in Arch-based distros.
# We add the current user to the audio group to ensure low-latency audio processing.
sudo usermod -aG audio "\$USER"
echo "Note: You might need to log out and back in for audio group changes to apply fully."

echo "=== 3. Verifying Nim Installation ==="
nim --version
nimble --version

echo "=== 4. Installing Raylib Bindings (naylib) ==="
nimble install -y naylib

echo "=== 5. Installing VS Code Extensions ==="
if command -v code &> /dev/null; then
    code --install-extension saem.nim
    code --install-extension formulahendry.code-runner
else
    echo "VS Code 'code' command line tool not found in PATH."
fi

echo "=== 6. Creating Project Structure with GameMode Integration ==="
# Create VS Code tasks folder
mkdir -p .vscode

# Generate tasks.json to compile and run with GameMode enabled
cat << 'EOF' > .vscode/tasks.json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Run Nim Game with GameMode (Debug)",
            "type": "shell",
            "command": "gamemoderun nim r src/main.nim",
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": true,
                "panel": "shared",
                "showReuseMessage": true,
                "clear": false
            }
        }
    ]
}
EOF

# Create source folder and main game file
mkdir -p src
cat << 'EOF' > src/main.nim
import naylib

initWindow(800, 450, "Nim + Raylib Template (CachyOS Optimized)")
setTargetFPS(60)

while not windowShouldClose():
  beginDrawing()
  clearBackground(LightGray)

  drawText("CachyOS GameMode & Pro-Audio Ready!", 190, 180, 20, DarkGray)
  drawText("Press ESC to exit.", 320, 220, 16, Gray)
  drawFPS(10, 10)

  endDrawing()

closeWindow()
EOF

# Create .gitignore to prevent committing build artifacts
cat << 'EOF' > .gitignore
# Nim compiler cache
nimcache/
# Compiled binaries
src/main
src/main.exe
*.exe
EOF

# Create a clean README for your GitHub repository
cat << 'EOF' > README.md
# Nim + Raylib Game Development Template (CachyOS Performance Edition)

A complete Linux game development boilerplate optimized for CachyOS using Nim, Raylib (`naylib`), VS Code, and Feral Interactive's GameMode.

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd <repo-name>
   ```

2. Make the setup script executable and run it:
   ```bash
   chmod +x setup_env.sh
   ./setup_env.sh
   ```

3. Open the project in VS Code:
   ```bash
   code .
   ```

## Performance & Audio Optimizations Included
* **GameMode:** Every time you build/run inside VS Code, the binary is launched via `gamemoderun`, which automatically tweaks CPU governors, GPU clocks, and process priority.
* **Pro-Audio:** Installs PipeWire infrastructure and links the current user to the `audio` group for native low-latency audio processing.

## How to Run
* **Inside VS Code:** Press `Ctrl+Shift+B` to automatically compile and run with GameMode.
* **From the terminal:** Run `gamemoderun nim r src/main.nim`
EOF

echo "=== Setup Complete! ==="
echo "You can now open the project in VS Code using: code ."
echo "Press Ctrl+Shift+B in VS Code to play with optimized kernel performance."
