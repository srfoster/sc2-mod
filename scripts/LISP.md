# Galaxy Lisp Documentation

A Lisp interpreter implemented in Galaxy Script for StarCraft II modding.

## Getting Started

Type `ui` in chat to open the Lisp UI dialog, or `lisp` for help.

## Language Features

### Basic Syntax

S-expressions are the fundamental syntax: `(command arg1 arg2 ...)`

### Data Types

- **Numbers**: `1`, `42`, `-5`
- **Strings**: `"Hello World"` (in log messages)
- **Symbols**: `'Marine`, `'Stimpack` (quoted identifiers)
- **Variables**: `x`, `marines` (evaluated to their values)
- **UnitGroup References**: `@unitgroup1`, `@unitgroup2` (returned by spawn)

## Core Commands

### Unit Spawning

```lisp
(spawn 'UnitType [count] [offsetX] [offsetY] [facing] [player])
```

Spawns units and returns a unitgroup reference.

**Parameters:**
- `UnitType` (required): Quoted unit name like `'Marine`, `'Zergling`, `'Stalker`
- `count` (default: 1): Number of units to spawn
- `offsetX` (default: 0): X coordinate offset from start location
- `offsetY` (default: 0): Y coordinate offset from start location
- `facing` (default: 90): Facing angle in degrees
- `player` (default: 1): Player number (1-16)

**Examples:**
```lisp
(spawn 'Marine)                    ; 1 marine at 0,0 facing 90 for player 1
(spawn 'Marine 5)                  ; 5 marines at 0,0 facing 90 for player 1
(spawn 'Zergling 10 20 0 90 2)    ; 10 zerglings at (20,0) for player 2
```

**Returns:** A unitgroup reference like `@unitgroup1` that can be stored in a variable.

### Upgrades

```lisp
(upgrade 'UpgradeName [player])
```

Researches a tech tree upgrade for a player.

**Parameters:**
- `UpgradeName` (required): Quoted upgrade name
- `player` (default: 1): Player number

**Examples:**
```lisp
(upgrade 'Stimpack)                    ; Research Stimpack for player 1
(upgrade 'zerglingmovementspeed 2)    ; Research zergling speed for player 2
```

**Common Upgrade Names:**
- Terran: `'Stimpack`, `'CombatShield`, `'ConcussiveShells`
- Zerg: `'zerglingmovementspeed`, `'zerglingattackspeed`, `'hydraliskspeed`
- Protoss: `'Charge`, `'Blink`

### Unit Commands

```lisp
(attack unitgroup-ref x y)
```

Issues an attack-move order to a unitgroup.

**Parameters:**
- `unitgroup-ref`: A unitgroup reference (from spawn or variable)
- `x`: Target X coordinate offset
- `y`: Target Y coordinate offset

**Example:**
```lisp
(define marines (spawn 'Marine 10))
(attack marines 20 0)    ; Attack-move to position (20,0)
```

### Variables

```lisp
(define variable-name value)
```

Defines a variable and assigns it a value.

**Examples:**
```lisp
(define x 5)
(define m 'Marine)
(define myunits (spawn 'Marine 10))
```

### Sequential Execution

```lisp
(begin expr1 expr2 expr3 ...)
```

Evaluates multiple expressions in sequence.

**Example:**
```lisp
(begin
  (define marines (spawn 'Marine 10))
  (upgrade 'Stimpack)
  (attack marines 20 0)
)
```

### Logging

```lisp
(log "message")
(log variable)
```

Outputs a message to the game chat and debug log.

**Examples:**
```lisp
(log "Hello World")
(define x 42)
(log x)
```

### Conditional Execution

```lisp
(if condition then-expr else-expr)
```

Evaluates `then-expr` if condition is true, otherwise evaluates `else-expr`.

**Example:**
```lisp
(define count 5)
(if (> count 0)
    (spawn 'Marine count 0 0 90)
    (log "No units to spawn")
)
```

### Arithmetic Operations

```lisp
(+ a b)    ; Addition
(- a b)    ; Subtraction
(* a b)    ; Multiplication
(/ a b)    ; Division
```

**Examples:**
```lisp
(define x (+ 5 3))        ; x = 8
(define y (* x 2))        ; y = 16
(spawn 'Marine (+ 3 2))   ; Spawn 5 marines
```

### Comparison Operations

```lisp
(> a b)    ; Greater than
(< a b)    ; Less than
(= a b)    ; Equal to
```

Returns true or false (used in `if` conditions).

**Examples:**
```lisp
(if (> count 10)
    (log "Many units")
    (log "Few units")
)
```

### Custom Functions

```lisp
(define (function-name param1 param2) body)
```

Defines a custom function that can be called later.

**Example:**
```lisp
(define (spawn-army count)
  (begin
    (spawn 'Marine count 0 0 90)
    (upgrade 'Stimpack)
  )
)

(spawn-army 10)    ; Spawns 10 marines and researches Stimpack
```

## Complete Examples

### Basic Unit Spawning
```lisp
(begin
  (spawn 'Marine 5)
  (spawn 'Marauder 3 5 0 90)
  (spawn 'Medivac 2 0 5 90)
)
```

### PvP Army Composition
```lisp
(begin
  (spawn 'Stalker 8)
  (spawn 'Zealot 4 2 2 90)
  (upgrade 'Charge)
  (upgrade 'Blink)
)
```

### Combat Scenario with Attack Commands
```lisp
(begin
  (define marines (spawn 'Marine 10))
  (define lings (spawn 'Zergling 15 20 0 90 2))
  (upgrade 'Stimpack)
  (upgrade 'zerglingmovementspeed 2)
  (attack marines 20 0)
)
```

### Using Variables and Arithmetic
```lisp
(begin
  (define count 5)
  (define doubled (* count 2))
  (spawn 'Marine doubled 0 0 90)
  (log "Spawned marines")
)
```

### Custom Function Example
```lisp
(begin
  (define (spawn-bio count)
    (begin
      (spawn 'Marine count 0 0 90)
      (spawn 'Marauder (/ count 2) 2 0 90)
      (upgrade 'Stimpack)
      (upgrade 'CombatShield)
    )
  )
  
  (spawn-bio 12)
)
```

### Attack-Move Example
```lisp
(begin
  (define army (spawn 'Marine 20))
  (upgrade 'Stimpack)
  (upgrade 'CombatShield)
  (attack army 30 10)
)
```

## Language Reference

### Unit Types (Common)

**Terran:**
- `'Marine`, `'Marauder`, `'Reaper`, `'Ghost`
- `'Hellion`, `'Hellbat`, `'Siege Tank`, `'Thor`
- `'Viking`, `'Medivac`, `'Liberator`, `'Banshee`, `'Raven`, `'Battlecruiser`
- `'SCV`, `'CommandCenter`, `'Barracks`, `'Factory`, `'Starport`

**Zerg:**
- `'Zergling`, `'Baneling`, `'Roach`, `'Ravager`, `'Hydralisk`, `'Lurker`
- `'Infestor`, `'Swarm Host`, `'Ultralisk`, `'Mutalisk`, `'Corruptor`, `'Brood Lord`
- `'Drone`, `'Queen`, `'Overlord`, `'Hatchery`, `'Spawning Pool`, `'Roach Warren`

**Protoss:**
- `'Probe`, `'Zealot`, `'Stalker`, `'Sentry`, `'Adept`, `'High Templar`, `'Dark Templar`
- `'Immortal`, `'Colossus`, `'Disruptor`, `'Archon`
- `'Phoenix`, `'Oracle`, `'Void Ray`, `'Carrier`, `'Tempest`
- `'Nexus`, `'Gateway`, `'Robotics Facility`, `'Stargate`

### Upgrade Names (Common)

**Terran:**
- `'Stimpack` - Marine/Marauder stim ability
- `'CombatShield` - Marine +10 HP
- `'ConcussiveShells` - Marauder slow effect

**Zerg:**
- `'zerglingmovementspeed` - Metabolic Boost (zergling speed)
- `'zerglingattackspeed` - Adrenal Glands (zergling attack speed)
- `'hydraliskspeed` - Muscular Augments
- `'evolvegroovedspines` - Grooved Spines (hydralisk range)

**Protoss:**
- `'Charge` - Zealot charge ability
- `'Blink` - Stalker blink ability
- `'ExtendedThermalLance` - Colossus range upgrade

## Implementation Notes

- UnitGroups are stored globally and referenced by ID (`@unitgroup1`, etc.)
- Default spawn location is relative to the player's start location
- Coordinates use an offset system from the start location
- Player IDs range from 1-16
- Angles are in degrees (0-360)
