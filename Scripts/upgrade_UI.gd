extends Button

signal item_selected(upgrade)

var upgrade: Upgrade

func setup(new_upgrade: Upgrade):
	upgrade = new_upgrade
	
	$ColorRect/Name.text = upgrade.name
	$ColorRect/Rarity.text = upgrade.Rarity.keys()[upgrade.rarity]
	$ColorRect/Desc.text = upgrade.description
	$ColorRect/Cost.text = str(upgrade.cost)

func _pressed() -> void:
	if globals.currency >= upgrade.cost:
		item_selected.emit(upgrade)
		$ColorRect/Button.disabled = true
		$ColorRect/Cost.text = "Sold"
	else:
		$ColorRect/Cost.text = "Can't Afford!"
		await get_tree().create_timer(1.0).timeout
		$ColorRect/Cost.text = str(upgrade.cost)
