extends Node

@export var all_upgrades: Array[Upgrade]

var current_offers: Array[Upgrade] = []

func roll_rarity() -> Upgrade.Rarity:
	var roll = randf()
	if roll < 0.60:
		return Upgrade.Rarity.COMMON
	elif roll < 0.85:
		return Upgrade.Rarity.UNCOMMON
	elif roll < 0.95:
		return Upgrade.Rarity.RARE
	else:
		return Upgrade.Rarity.EPIC

func generate_shop():
	current_offers.clear()
	while current_offers.size() < 3:
		var rarity = roll_rarity()
		var candidates: Array[Upgrade] = []
		for upgrade in all_upgrades:
			if upgrade.rarity == rarity:
				candidates.append(upgrade)
			
		if candidates.is_empty():
			roll_rarity()
		
		var chosen = candidates.pick_random()
		
		if not current_offers.has(chosen):
			current_offers.append(chosen)
