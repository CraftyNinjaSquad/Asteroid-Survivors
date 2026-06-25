extends Resource

class_name Upgrade

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY
}

##Upgrade Details 
@export var name: String
@export_multiline() var description: String
@export var rarity: Rarity
@export var cost: int

##Upgraded stat
@export var stat_name:String

##upgrade amount
@export var value:float
