extends Resource
class_name BalanceData

## Resource for all balances in the game.

enum Levels {
	AnkyBoss,
	LockedBoss
}

## Balances for each level (ones loaded in level select)
@export var levelsBalances : Dictionary[Levels, LevelData]
