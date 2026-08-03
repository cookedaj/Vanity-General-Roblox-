# Vanity-General - Architecture

This document describes the modular source under `src/`. Optional security
modules (`StringObfuscation`, `DebuggerDetection`, `ProtectedSecrets`) live
under `src/security/` and are bundled into `dist/VanityGeneral_INTEGRATED.lua`,
the single-file executor build.

## System Overview

```
VanityGeneralController
├── MainController (LocalScript)
│   └── Orchestrates everything
│
├── Configuration (ModuleScript)
│   └── Centralized settings
│
├── CameraDirector (ModuleScript)
│   ├── FindBestTarget()
│   ├── PointCamera()
│   └── Update()
│
├── ESP (ModuleScript)
│   ├── Init()
│   ├── Update()
│   ├── OnPlayerAdded()
│   ├── OnPlayerRemoving()
│   └── Cleanup()
│
└── UI (ModuleScript)
    ├── Init()
    ├── Toggle()
    └── Cleanup()
```

## Data Flow

```
┌─────────────────────────────────────────────────┐
│        Configuration (Single Source of Truth)   │
└─────────────────────────────────────────────────┘
         │                       │
         ▼                       ▼
   ┌──────────────┐       ┌──────────────┐
   │ CameraDir    │       │ ESP System   │
   │ - Tracks     │       │ - Highlights │
   │ - Targets    │       │ - Renders    │
   └──────────────┘       └──────────────┘
         │                       │
         └───────────┬───────────┘
                     ▼
            ┌─────────────────┐
            │  MainController │
            │  RenderStepped  │
            └─────────────────┘
                     │
                     ▼
            ┌─────────────────┐
            │   UI System     │
            │  (Reads Config) │
            │ (Updates Config)│
            └─────────────────┘
                     │
                     ▼
            ┌─────────────────┐
            │  User Input     │
            │  (RightShift)   │
            └─────────────────┘
```

## Module Responsibilities

### Configuration
- Stores all settings in one place
- No logic, only data
- Updated by UI and code
- Read by all systems

**Sections:**
- `Camera`: Track settings
- `ESP`: Highlight settings
- `UI`: Interface settings

### CameraDirector
- **FindBestTarget(config)**: Finds closest, visible target
  - Iterates players
  - Checks alive status
  - Filters by MaxDistance (world-space range in studs)
  - Ranks candidates by screen distance
  - Validates visibility with raycast
  - Returns best match or nil

- **PointCamera(position, smoothness)**: Moves camera
  - Creates desired CFrame
  - Lerps to target smoothly
  - Only positioning, no selection

- **Update(config, debug)**: Main update function
  - Calls FindBestTarget
  - Calls PointCamera if target found
  - Prints the tracked target when `debug` (the top-level
    `Configuration.Debug` flag) is set
  - Returns current target for UI

### ESP
- **Init()**: Setup highlight system
  - Creates container folder
  - Creates initial player entries
  - Prepares shell folder

- **Update(config)**: Per-frame rendering
  - Adds new players
  - Updates all highlights
  - Manages shells for thickness
  - Syncs shell positions

- **OnPlayerAdded/Removed()**: Player lifecycle
  - Creates/destroys highlight instances
  - Prevents memory leaks

- **Cleanup()**: Full teardown
  - Destroys all highlights
  - Cleans shell folder
  - Clears entries table

### UI
- **Init(config, resetCallback)**: Build interface
  - Creates ScreenGui + CanvasGroup window
  - Starts a single shared input router (three UserInputService connections:
    InputChanged, InputEnded, InputBegan)
  - Builds all tabs (Aimbot, ESP, Settings)
  - Connects toggles and sliders

- **Toggle() / Show() / Hide()**: Fade window in/out
  - Animated via CanvasGroup GroupTransparency
  - Writes `Visible` back to `config.UI.Visible`

- **SetCurrentTarget(name)**: Update the Aimbot tab "Current Target" row

- **IsCapturingKey()**: True while a keybind box is armed; controllers check
  this so an armed press rebinds instead of firing a hotkey

- **Notify(text, duration)**: Show a transient on-screen notification

- **SyncControls()**: Re-read config into every control
  - Used after a settings reset or a keybind toggle

- **Cleanup()**: Remove all UI elements
  - Disconnects the shared input connections
  - Destroys ScreenGui
  - Clears references

### MainController
- **init()**: Initialize all systems
  - Create ESP
  - Create UI
  - Connect input handlers
  - Start RenderStepped loop

- **cleanup()**: Shutdown everything (bound to the UnloadKey, default End)
  - Disconnect all connections
  - Call system cleanups
  - Clear references

- **RenderStepped Loop**: Main update
  ```lua
  RunService.RenderStepped:Connect(function()
      ESP:Update(Configuration.ESP)
      CameraDirector:Update(Configuration.Camera, Configuration.Debug)
  end)
  ```

## Performance Characteristics

### Memory
- Single highlight per player
- Shell only created for thickness > 1
- Proper cleanup prevents leaks
- ~2-5 MB for 50 players with ESP on

### CPU
- RenderStepped: ~1-2ms per frame
  - Camera: 0.3-0.8ms (target calc + raycast)
  - ESP: 0.5-1.5ms (highlight updates)
  - UI: <0.1ms (cached, updates on input)

### Network
- No network traffic
- Fully client-side
- No replication needed

## Key Design Decisions

### Single RenderStepped Connection
- **Why**: Avoid multiple connections competing
- **How**: Both systems update from same loop
- **Benefit**: Predictable performance

### Centralized Configuration
- **Why**: No sync issues or state conflicts
- **How**: Single source of truth
- **Benefit**: Easy settings management

### Separate Modules
- **Why**: Each has single responsibility
- **How**: No circular dependencies
- **Benefit**: Easy to test and modify

### Shell System for Outlines
- **Why**: Roblox highlights have limited thickness
- **How**: Clone and enlarge character parts
- **Benefit**: Thick outlines without custom rendering

### Raycast Visibility
- **Why**: Highlight targets behind walls
- **How**: Cast ray from camera to target
- **Benefit**: Realistic visibility

## Extension Points

### Add New Feature (Example: Keybinds)
1. Add to Configuration
2. Handle in UI Tab
3. Read in MainController InputBegan

### Add New Target Filter (Example: Teams)
1. Add to Configuration
2. Modify CameraDirector:FindBestTarget()
3. Add UI control in Settings tab

### Add New ESP Mode (Example: Skeleton)
1. New function in ESP module
2. Toggle in UI
3. Call from Update()

### Add Notifications (Example: Target Changed)
1. Create UI notification component
2. Call from CameraDirector:Update()
3. Auto-hide after time

## Common Issues & Solutions

### Camera Jittering
- Lower Smoothness value (default 0.15)
- Increase MaxDistance threshold

### ESP Lag
- Reduce max distance
- Disable thickness (use outline only)
- Disable filled mode

### Memory Leak
- Ensure Cleanup() called on player leave
- Check shell folder destroying properly
- Verify connections disconnected

### UI Unresponsive
- Not a common issue if input handling works
- Check UserInputService connections
- Verify UI module initialized

## Testing Checklist

- [ ] Camera tracks nearest visible player
- [ ] ESP highlights all players in range
- [ ] Visibility check ignores behind-wall targets
- [ ] Menu opens/closes with RightShift
- [ ] All sliders update in real-time
- [ ] Color picker selects correct colors
- [ ] Reset button restores defaults
- [ ] No lag when 30+ players present
- [ ] No memory leaks after 1+ hour
- [ ] Proper cleanup on game leave

## Performance Optimization Tips

1. **Lower ESP MaxDistance** if seeing lag
2. **Disable Filled mode** when performance-critical
3. **Reduce Outline Opacity** for faster rendering
4. **Use default Thickness (1)** instead of thick outlines
5. **Disable Camera** when not needed

---

This architecture enables easy maintenance, testing, and feature addition while maintaining high performance.
