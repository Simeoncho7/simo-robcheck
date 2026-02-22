# Robbery Check for FiveM (QBCore)

A FiveM resource that allows players to check police presence before attempting robberies. Players can interact with an NPC to see which robbery types are feasible based on the number of on-duty police officers.

## Features

- Check real-time police count
- NPC interaction for robbery intel
- Configurable robbery types with required police thresholds
- Integration with QBCore and ox_lib

## Dependencies

- [QBCore Framework](https://github.com/qbcore-framework)
- [ox_lib](https://github.com/overextended/ox_lib)

## Installation

1. Download the resource and place it in your `resources` folder
2. Add `start simo-robcheck` to your `server.cfg`
3. Ensure the dependencies are installed and started

## Configuration

### Robbery Types

Edit the `Robberies` table in `client.lua` to configure different robbery types and their required police counts:

```lua
local Robberies = {
    { name = "Store Robbery", requiredCops = 1 },
    { name = "Fleeca Bank",    requiredCops = 3 },
    { name = "Jewelry Store",  requiredCops = 5 },
    { name = "Pacific Bank",   requiredCops = 8 },
}
```

Add or modify entries as needed. Each entry has:
- `name`: Display name of the robbery type
- `requiredCops`: Minimum number of on-duty police required

### NPC Configuration

In `client.lua`, you can change the NPC appearance and location:

```lua
local PedModel = `a_m_m_og_boss_01`  -- NPC model hash
local PedCoords = vec4(1185.1, -1337.76, 34.92, 203.22)  -- Location and heading
```

- `PedModel`: Change to any valid ped model hash
- `PedCoords`: Vector4 with x, y, z coordinates and heading rotation

## Usage

1. Start your server with the resource enabled
2. Players approach the NPC at the configured location
3. Use the target system (ox_target) to interact with "Talk to the Boss"
4. View the intel menu showing which robberies are currently feasible
5. Green checkmarks indicate enough police are online, red X marks indicate too much heat

## How It Works

- The client script checks police count via a server callback
- Only counts on-duty police officers
- Updates in real-time when the menu is opened
- Provides visual feedback through colored icons and notifications

## Support

For issues or questions, please create an issue on this GitHub repository.

## License

This project is open source. Feel free to modify and distribute.

## Credits

- Author: Simeoncho
- Framework: QBCore
- UI Library: ox_lib
