# TheMod Development Guide

Ideas for future features:

* (for-player ...) Param
* (clear)
* (a-move [GROUP] [POS])

## Drills

(begin
  (spawn 'Marine 10)
  (upgrade 'Stimpack)
  (spawn 'Zergling 15 5 0 90 2)
  (upgrade 'zerglingmovementspeed 2)
)


## Development Cycle

1. **Edit Code**: Modify `Main.galaxy` in this directory
2. **Test in Editor**: Load the mod in SC2 Editor and run the map
3. **Check Logs**: See instructions below
4. **Check Bank Data**: Bank files are saved between runs for persistence

## Checking Debug Logs

The debug logs are written to a file based on the map name you're testing on. The log filename is set by `TriggerDebugSetTypeFile()` in `Main_init()`.

**Current log file**: `config_test.txt`

### Finding Your Logs

1. Logs are in: `%USERPROFILE%/Documents/StarCraft II/UserLogs/<MapName>/`
2. The map name depends on which map you load in the editor (e.g., "10000 Feet LE_FE36CD26")

### How to Read Logs

**Using bash/Git Bash** (recommended):
```bash
cat "$USERPROFILE/Documents/StarCraft II/UserLogs/10000 Feet LE_FE36CD26/config_test.txt"
```

**List available log directories**:
```bash
ls -la "$USERPROFILE/Documents/StarCraft II/UserLogs/"
```

**Find most recent logs**:
```bash
ls -lt "$USERPROFILE/Documents/StarCraft II/UserLogs/10000 Feet LE_FE36CD26"/*.txt | head -5
```

**Using Windows Command Prompt**:
```cmd
type "%USERPROFILE%\Documents\StarCraft II\UserLogs\10000 Feet LE_FE36CD26\config_test.txt"
```

## File Locations

### Debug Logs
```
%USERPROFILE%/Documents/StarCraft II/UserLogs/<MapName>/config_test.txt
```

Where `<MapName>` is the name of the map you're testing on (e.g., "10000 Feet LE_FE36CD26").

**Quick check**:
```bash
cat "$USERPROFILE/Documents/StarCraft II/UserLogs/10000 Feet LE_FE36CD26/config_test.txt"
```

### Bank Files (Persistence)
```
%USERPROFILE%/Documents/StarCraft II/Banks/TestBank.SC2Bank
```

**Note**: Banks only work on Battle.net published maps, not in local test maps.

## Debugging

- **Log() function**: Use `Log("message")` to output both in-game chat and debug log file
- **In-game messages**: Debug output appears in chat
- **Log files**: Written to UserLogs/<MapName>/ directory
- **Bank inspection**: Check `.SC2Bank` XML files directly

### Logging Best Practices

Always use the `Log()` helper function instead of calling `UIDisplayMessage` and `TriggerDebugOutput` separately:

```c
// Good
Log("Player spawned at: " + IntToString(x));

// Bad - don't do this
UIDisplayMessage(PlayerGroupAll(), c_messageAreaChat, StringToText("message"));
TriggerDebugOutput(1, StringToText("message"), false);
```

## Common Issues

- **Variables**: Must be declared at top of function (C89 style)
- **Bank signature**: Set `BankOptionSet(bank, c_bankOptionSignature, true)` for persistence
- **Player ID**: Use consistent player ID (we use `lp_player = 1`)
