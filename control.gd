extends Control

var warnings = 0
var numOfTasks = 3
var tasksCompleted = 0
var day = 1
var money = 0
var package = [0,0,0]
var order = [randi_range(0,3), randi_range(0,3), randi_range(0,3)] 
var stock = [10,10,10] #A, B, C

func _ready():
	$Terminal/Control/Order/Label.text = "A *" + str(order[0]) + "\nB *" + str(order[1]) + "\nC *" + str(order[2])

func _on_open_button_up():
	$Open.visible = false
	$OpenStock.visible = false
	$Terminal.visible = true
	$Package.visible = false
	$Finish.visible = false
	$Label1.visible = false

func _on_close_button_up():
	$Open.visible = true
	$OpenStock.visible = true
	$Terminal.visible = false
	$Package.visible = true
	$Finish.visible = true
	$Label1.visible = true

func _on_open_stock_button_up():
	$Open.visible = false
	$OpenStock.visible = false
	$Stock.visible = true
	$Package.visible = false
	$Finish.visible = false
	$Label1.visible = false

func _on_close_stock_button_up():
	$Open.visible = true
	$OpenStock.visible = true
	$Stock.visible = false
	$Package.visible = true
	$Finish.visible = true
	$Label1.visible = true

func _on_a_button_up():
	if stock[0] > 0 and package[0] < 3:
		package[0] = package[0] + 1
		$Package/Control/Label2.text = $Package/Control/Label2.text + "\nA"
		stock[0] = stock[0] - 1
	print(stock)
	print(package)

func _on_b_button_up():
	if stock[1] > 0 and package[1] < 3:
		package[1] = package[1] + 1
		$Package/Control/Label2.text = $Package/Control/Label2.text + "\nB"
		stock[1] = stock[1] - 1
	print(stock)
	print(package)

func _on_c_button_up():
	if stock[2] > 0 and package[2] < 3:
		package[2] = package[2] + 1
		$Package/Control/Label2.text = $Package/Control/Label2.text + "\nC"
		stock[2] = stock[2] - 1
	print(stock)
	print(package)

func _on_clear_button_up():
	$Package/Control/Label2.text = ""
	for i in range(3):
		stock[i] = stock[i] + package[i]
		package[i] = 0
	print(stock)
	print(package)

func _on_finish_button_up():
	var valid = true
	for i in range(len(order)):
		if package[i] != order[i]:
			valid = false
			print("incorrect order")
			break
	if valid:
		for i in range(len(package)-1):
			if package[i] == 3:
				money += 5
		money += 15
		package = [0,0,0]
		print("order complete")
		order = [randi_range(0,3), randi_range(0,3), randi_range(0,3)]
		$Label1.text = "Money: " + str(money)
		$Package/Control/Label2.text = ""
		$Terminal/Control/Order/Label.text = "A *" + str(order[0]) + "\nB *" + str(order[1]) + "\nC *" + str(order[2])
		tasksCompleted += 1
	elif !valid:
		warnings += 1
		_on_clear_button_up()
		if warnings == 3:
			print("you lost")
			get_tree().quit()
	if tasksCompleted == numOfTasks:
		warnings = 0
		tasksCompleted = 0
		day += 1
		numOfTasks += randi_range(1,3)
		$Label2.text = "Day " + str(day)
		$Restock.visible = true
		$Restock/Label1.text = "Money: " + str(money)

func _on_a_2_button_up():
	if money > 0:
		stock[0] += 1
		money -= 5
		print(stock)
		$Restock/Label1.text = "Money: " + str(money)

func _on_b_2_button_up():
	if money > 0:
		stock[1] += 1
		money -= 5
		print(stock)
		$Restock/Label1.text = "Money: " + str(money)

func _on_c_2_button_up():
	if money > 0:
		stock[2] += 1
		money -= 5
		print(stock)
		$Restock/Label1.text = "Money: " + str(money)

func _on_done_button_up():
	$Restock.visible = false
	_on_clear_button_up()
	$Label1.text = "Money: " + str(money)
	print("new num of tasks : " + str(numOfTasks))
