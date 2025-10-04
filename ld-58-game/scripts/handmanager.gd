extends Node
signal update_inventory
var Items: Array[Item] = []

func addItem(item):
	Items.append(item)
	update_inventory.emit()

func delItem(item):
	if Items.has(item):
		Items.erase(item)
		update_inventory.emit()
