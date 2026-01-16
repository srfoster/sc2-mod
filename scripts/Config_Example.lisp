; Config_Example.lisp
; More complex examples showing what's possible with s-expressions

; Simple unit spawn
(unit Marine 5 10 10 0)

; Base with specific building type
(base Nexus 0 0 12)

; Multiple units at same location (grouped)
(spawn-group 
  (location 15 15)
  (unit Zealot 3 0 0 90)
  (unit Stalker 2 0 0 90))

; Named parameters style (future feature)
(unit Marine :count 8 :x 3 :y 0 :facing 90)

; Nested example (future feature)
(army 
  (player 1)
  (location 20 20)
  (units
    (Marine 10)
    (Medivac 2)))
