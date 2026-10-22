# tux-game-setup
My automated linux game dev and gaming setups

## Cachy OS
> [!NOTE]
> Currently, this automation and optimization setup explicitly targets **CachyOS**.

Run following:

```bash
# Make the setup script executable
chmod +x cachyos_env_setup.sh

# Run the script to configure your environment and project
./cachyos_env_setup.sh
```

### After Setup
Once the script finishes successfully, you can jump straight into development:

1. **Open the project in VS Code:**
   ```bash
   code .
   ```
2. **Run your game:** 
   * **In VS Code:** Press `Ctrl+Shift+B` to automatically launch the game with **GameMode** performance optimizations.
   * **In the Terminal:** Run `gamemoderun nim r src/main.nim`

### Features Configured (CachyOS Specific)
* **Optimized Execution:** Integrated Feral Interactive's `gamemoderun` to maximize CPU and GPU clocks during testing, taking advantage of the custom CachyOS kernels.
* **Pro-Audio Ready:** Configured user groups and PipeWire dependencies for low-latency audio processing.
* **Modern Toolchain:** Uses rolling-release native Arch/CachyOS packages (`pacman`) for Nim, Nimble, and VS Code.

