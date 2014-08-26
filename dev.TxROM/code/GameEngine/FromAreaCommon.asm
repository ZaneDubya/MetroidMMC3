.alias EnemyDataTable7B     $977B
.alias EnemyDataPtrTable    $96DB

AreaCommon80B0:
    LDY EnDataIndex,X               
    LDA EnemyDataTable7B,Y
    ASL                             ;*2 
    RTS