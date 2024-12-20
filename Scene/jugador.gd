extends CharacterBody2D

const speed = 100
var current_dir = "none"

var maxMovements = 150
var maxHp = 20
var maxActions = 5

var totemDeadsCount = 0
var isWarlokKillable = false

var currentMovements = maxMovements
var currentHp = maxHp
var currentActions = maxActions

var selectedSpellHeal = false
var selectedSpellMovement = false
var selectedSpellFire = false
var selectedSpellMagic = false
var selectedSpellIce = false
var selectedSpellInstaKill = false

var cdSpellHeal = 0
var cdSpellMovement = 0

var rng = RandomNumberGenerator.new()

var totemsDestroyed = 0

var isFireDead = false
var isIceDead = false
var isTotemDead = false
var isWarlockDead = false

var winCondition = false

func _ready():
	$AnimatedSprite2D.play("idle_down")
	$"../currentMovement".text = str(currentMovements)
	setDamageLogsHiden()
	$lastEffectOnPlayer.text = ""
	$"../finalSceneLayer".hide()
	$"../finalBackground".hide()
	$playerAnimatedEffects.play("defaultNone")
	$"../warlock/throwSpellAnimation".play("throwingSpell")
	$"../warlock/warlockChargeAttack".play("warlockAttack")
	$"../spellFire/CITfire".hide()
	$"../spellMagic/CITmagic".hide()
	$"../spellIce/CITice".hide()
	$"../spellInstaKill/CITinstaKill".hide()
	get_window().content_scale_factor = 2.0
	
func _physics_process(delta):
	player_movement(delta)



func player_movement(delta):
	if Input.is_key_pressed(KEY_D) and currentMovements > 0:
		current_dir = "right"
		player_animation(1)
		velocity.x = speed
		velocity.y = 0
		currentMovements = currentMovements-1
		actualizarHudMovimiento()
		
	elif Input.is_key_pressed(KEY_A) and currentMovements > 0:
		current_dir = "left"
		player_animation(1)
		velocity.x = -speed
		velocity.y = 0
		currentMovements = currentMovements-1
		actualizarHudMovimiento()
		
	elif Input.is_key_pressed(KEY_S) and currentMovements > 0:
		current_dir = "down"
		player_animation(1)
		velocity.x = 0
		velocity.y = speed
		currentMovements = currentMovements-1
		actualizarHudMovimiento()
		
	elif Input.is_key_pressed(KEY_W) and currentMovements > 0:
		current_dir = "up"
		player_animation(1)
		velocity.x = 0
		velocity.y = -speed
		currentMovements = currentMovements-1
		actualizarHudMovimiento()
		
	else:
		player_animation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func setDamageLogsHiden():
	if isFireDead == false:
		$"../fireTotem/damageLog".hide()
	if isIceDead == false:
		$"../iceTotem/damageLog".hide()
	if isTotemDead == false:
		$"../totem/damageLog".hide()
	if isWarlockDead == false:
		$"../warlock/damageLog".hide()

func actualizarHudMovimiento():
	$"../currentMovement".text = str(currentMovements)
	if(currentMovements < 2):
		$"../movementIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Energy Bar/Energy Stage 5.png")
	elif(currentMovements < 30):
		$"../movementIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Energy Bar/Energy Stage 4.png")
	elif(currentMovements < 70):
		$"../movementIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Energy Bar/Energy Stage 3.png")
	elif(currentMovements < 100):
		$"../movementIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Energy Bar/Energy Stage 2.png")
	else:
		$"../movementIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Energy Bar/Energy Stage 1.png")

func player_animation(movement):
	var dir = current_dir
	var animation = $AnimatedSprite2D
	
	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("run_right")
		elif movement == 0:
			animation.play("idle_right")
	if dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("run_right")
		elif movement == 0:
			animation.play("idle_right")
	if dir == "down":
		if movement == 1:
			animation.play("run_down")
		elif movement == 0:
			animation.play("idle_down")
	if dir == "up":
		if movement == 1:
			animation.play("run_up")
		elif movement == 0:
			animation.play("idle_up")

func _on_button_button_down() -> void:
	currentMovements = maxMovements
	$"../currentMovement".text = str(currentMovements)
	$"../movementIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Energy Bar/Energy Stage 1.png")
	currentActions = maxActions
	$"../currentActions".text = str(currentActions) + "/" + str(maxActions)
	$"../actionIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Diamond Bar/Diamond Stage 1.png")
	var randomHpLost = round(rng.randf_range(1, 3))
	currentHp = currentHp - randomHpLost
	actualizarHudVida()
	actualizarHudAcciones()
	actualizarCDs()
	deselectAllSpells()
	setDamageLogsHiden()
	$lastEffectOnPlayer.text = "[center][b][color=#000000]-" + str(randomHpLost) + "[/color][/b][/center]"
	$playerAnimatedEffects.play("defaultNone")
	$"../warlock/throwSpellAnimation".play("throwingSpell")
	$"../warlock/warlockChargeAttack".play("warlockAttack")
	await get_tree().create_timer(1).timeout
	$playerDamagedEffect.play("getDamaged")
	
	CITspells()
	
	if currentHp < 1:
		$"../finalSceneLayer".show()
		$"../finalBackground".show()
		$"../finalSceneLayer/combatWin".text = "[center][b]¡ You losed ![/b][/center]"
		
	if(currentHp < 1):
		pass

func actualizarHudVida():
	$"../currentHP".text = str(currentHp)
	if(currentHp < 2):
		$"../hpIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Heart Bar/Heart Stage 5.png")
	elif(currentHp < 6):
		$"../hpIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Heart Bar/Heart Stage 4.png")
	elif(currentHp < 12):
		$"../hpIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Heart Bar/Heart Stage 3.png")
	elif(currentHp < 18):
		$"../hpIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Heart Bar/Heart Stage 2.png")
	else:
		$"../hpIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Heart Bar/Heart Stage 1.png")

func actualizarHudAcciones():
	$"../currentActions".text = str(currentActions)
	if currentActions < 1:
		$"../actionIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Diamond Bar/Diamond Stage 5.png")
	elif currentActions < 2:
		$"../actionIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Diamond Bar/Diamond Stage 4.png")
	elif currentActions < 3:
		$"../actionIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Diamond Bar/Diamond Stage 3.png")
	elif currentActions < 4:
		$"../actionIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Diamond Bar/Diamond Stage 2.png")
	else:
		$"../actionIcon".texture = load("res://Assets/Sprites/Health and Points Bars/Sprites/Diamond Bar/Diamond Stage 1.png")

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = "CoffeZebra\n\n[color=#000000]Resistencias:[/color]\n[color=#ee2d27]Fuego: 15%[/color]\n[color=#c71ef5]Mágia: 15%[/color]\n[color=#1195e0]Hielo: 15%[/color]"


func _on_spell_heal_button_up() -> void:
	deselectAllSpells()
	selectedSpellHeal = true
	$playerAnimatedEffects.play("arealRangeHeal")

func _on_spell_movement_button_up() -> void:
	deselectAllSpells()
	selectedSpellMovement = true
	$playerAnimatedEffects.play("arealRangeMovement")

func _on_spell_fire_button_up() -> void:
	deselectAllSpells()
	selectedSpellFire = true
	$playerAnimatedEffects.play("arealRangeFire")

func _on_spell_magic_button_up() -> void:
	deselectAllSpells()
	selectedSpellMagic = true
	$playerAnimatedEffects.play("arealRangeMage")

func _on_spell_ice_button_up() -> void:
	deselectAllSpells()
	selectedSpellIce = true
	$playerAnimatedEffects.play("arealRangeIce")

func _on_spell_insta_kill_button_up() -> void:
	deselectAllSpells()
	selectedSpellInstaKill = true
	$playerAnimatedEffects.play("arealRangeInstaKill")


func deselectAllSpells():
	selectedSpellFire = false
	selectedSpellIce = false
	selectedSpellMagic = false
	selectedSpellInstaKill = false
	selectedSpellMovement = false
	selectedSpellHeal = false
	$playerAnimatedEffects.play("defaultNone")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if selectedSpellHeal == true and cdSpellHeal < 1 and currentActions > 2:
			var randomHeal = round(rng.randf_range(1, 3))
			currentHp = currentHp + randomHeal
			cdSpellHeal = 3
			currentActions = currentActions -3
			$"../spellHeal/textCdSpellHeal".show()
			$"../spellHeal/CITheal".show()
			$"../spellHeal/textCdSpellHeal".text = "[center][color=#ffffff]" + str(cdSpellHeal) + "[/color][/center]"
			$"../currentHP".text = str(currentHp)
			$"../currentActions".text = str(currentActions)
			$lastEffectOnPlayer.text = "[center][b][color=#ffffff]+" + str(randomHeal) + "[/color][/b][/center]"
			actualizarHudVida()
			actualizarHudAcciones()
			deselectAllSpells()
			$effectOnYou.play("castHeal")
		elif selectedSpellMovement == true and cdSpellMovement < 1 and currentActions > 2:
			currentMovements = currentMovements +100
			cdSpellMovement = 2
			currentActions = currentActions -3
			$"../spellMovement/textCdSpellMovement".show()
			$"../spellMovement/CITmovement".show()
			$"../spellMovement/textCdSpellMovement".text = "[center][color=#ffffff]" + str(cdSpellMovement) + "[/color][/center]"
			$"../currentMovement".text = str(currentMovements)
			$"../currentActions".text = str(currentActions)
			$lastEffectOnPlayer.text = "[center][b][color=yellow]+100[/color][/b][/center]"
			actualizarHudMovimiento()
			actualizarHudAcciones()
			deselectAllSpells()
			$effectOnYou.play("castMovement")
	
	CITspells()


func actualizarCDs():
	cdSpellHeal = cdSpellHeal -1
	cdSpellMovement = cdSpellMovement -1
	
	if cdSpellHeal < 1:
		$"../spellHeal/textCdSpellHeal".hide()
		$"../spellHeal/CITheal".hide()
	else:
		$"../spellHeal/textCdSpellHeal".text = "[center][color=#ffffff]" + str(cdSpellHeal) + "[/color][/center]"
		$"../spellHeal/CITheal".show()

	if cdSpellMovement < 1:
		$"../spellMovement/textCdSpellMovement".hide()
		$"../spellMovement/CITmovement".hide()
	else:
		$"../spellMovement/textCdSpellMovement".text = "[center][color=#ffffff]" + str(cdSpellMovement) + "[/color][/center]"
		$"../spellMovement/CITmovement".show()


func _on_fire_totem_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var isAtRange = false
		if $"../fireTotem".position.distance_to($".".position) < 55:
			isAtRange = true
		
		if selectedSpellFire == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../fireTotem".actualHp = $"../fireTotem".actualHp - randomDamage
			$"../fireTotem/Label".text = str($"../fireTotem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellFire = false
			actualizarHudAcciones()
			$"../fireTotem/damageLog".text = "[color=#ee2d27]-" + str(randomDamage) + "[/color]"
			$"../fireTotem/damageLog".show()
			$"../animationFireDead".play("damagedWithFire")
			deselectAllSpells()
		elif selectedSpellMagic == true and currentActions > 1 and isAtRange:
			var randomDamage = round(rng.randf_range(1, 2))
			$"../fireTotem".actualHp = $"../fireTotem".actualHp - randomDamage
			$"../fireTotem/Label".text = str($"../fireTotem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellMagic = false
			actualizarHudAcciones()
			$"../fireTotem/damageLog".text = "[color=#c71ef5]-" + str(randomDamage) + "[/color]"
			$"../fireTotem/damageLog".show()
			deselectAllSpells()
			$"../animationFireDead".play("damagedWithMagic")
		elif selectedSpellIce == true and currentActions > 1 and isAtRange:
			var randomDamage = round(rng.randf_range(2, 5))
			$"../fireTotem".actualHp = $"../fireTotem".actualHp - randomDamage
			$"../fireTotem/Label".text = str($"../fireTotem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellIce = false
			actualizarHudAcciones()
			$"../fireTotem/damageLog".text = "[color=#1195e0]-" + str(randomDamage) + "[/color]"
			$"../fireTotem/damageLog".show()
			deselectAllSpells()
			$"../animationFireDead".play("damagedWithIce")
		elif selectedSpellInstaKill == true and currentActions > 4:
			var randomDamage = 0
			$"../fireTotem".actualHp = $"../fireTotem".actualHp - randomDamage
			$"../fireTotem/Label".text = str($"../fireTotem".actualHp) + "/12"
			currentActions = currentActions -5
			selectedSpellInstaKill = false
			actualizarHudAcciones()
			$"../fireTotem/damageLog".text = "[i][color=#c80c64]Inmune[/color][/i]"
			$"../fireTotem/damageLog".show()
			deselectAllSpells()
	
	CITspells()
	
	if $"../fireTotem".actualHp < 1:
		$"../animationFireDead".play()
		$"../fireTotem".queue_free()
		totemsDestroyed = totemsDestroyed +1
		isFireDead = true
	
	if totemsDestroyed > 2:
		$"../warlock".isKilleable = true

func _on_ice_totem_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var isAtRange = false
		if $"../iceTotem".position.distance_to($".".position) < 55:
			isAtRange = true
			
		if selectedSpellFire == true and currentActions > 1 and isAtRange:
			var randomDamage = round(rng.randf_range(2, 5))
			$"../iceTotem".actualHp = $"../iceTotem".actualHp - randomDamage
			$"../iceTotem/Label".text = str($"../iceTotem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellFire = false
			actualizarHudAcciones()
			$"../iceTotem/damageLog".text = "[color=#ee2d27]-" + str(randomDamage) + "[/color]"
			$"../iceTotem/damageLog".show()
			$"../animationIceDead".play("damagedWithFire")
			deselectAllSpells()
		elif selectedSpellMagic == true and currentActions > 1 and isAtRange:
			var randomDamage = round(rng.randf_range(1, 2))
			$"../iceTotem".actualHp = $"../iceTotem".actualHp - randomDamage
			$"../iceTotem/Label".text = str($"../iceTotem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellMagic = false
			actualizarHudAcciones()
			$"../iceTotem/damageLog".text = "[color=#c71ef5]-" + str(randomDamage) + "[/color]"
			$"../iceTotem/damageLog".show()
			deselectAllSpells()
			$"../animationIceDead".play("damagedWithMagic")
		elif selectedSpellIce == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../iceTotem".actualHp = $"../iceTotem".actualHp - randomDamage
			$"../iceTotem/Label".text = str($"../iceTotem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellIce = false
			actualizarHudAcciones()
			$"../iceTotem/damageLog".text = "[color=#1195e0]-" + str(randomDamage) + "[/color]"
			$"../iceTotem/damageLog".show()
			deselectAllSpells()
			$"../animationIceDead".play("damagedWithIce")
		elif selectedSpellInstaKill == true and currentActions > 4:
			var randomDamage = 0
			$"../iceTotem".actualHp = $"../iceTotem".actualHp - randomDamage
			$"../iceTotem/Label".text = str($"../iceTotem".actualHp) + "/12"
			currentActions = currentActions -5
			selectedSpellInstaKill = false
			actualizarHudAcciones()
			$"../iceTotem/damageLog".text = "[i][color=#c80c64]Inmune[/color][/i]"
			$"../iceTotem/damageLog".show()
			deselectAllSpells()
	
	CITspells()
	
	if $"../iceTotem".actualHp < 1:
		$"../animationIceDead".play("iceDead")
		$"../iceTotem".queue_free()
		totemsDestroyed = totemsDestroyed +1
		isIceDead = true
	
	if totemsDestroyed > 2:
		$"../warlock".isKilleable = true

func _on_totem_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var isAtRange = false
		if $"../totem".position.distance_to($".".position) < 55:
			isAtRange = true
		
		if selectedSpellFire == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../totem".actualHp = $"../totem".actualHp - randomDamage
			$"../totem/Label".text = str($"../totem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellFire = false
			actualizarHudAcciones()
			$"../totem/damageLog".text = "[color=#ee2d27]-" + str(randomDamage) + "[/color]"
			$"../totem/damageLog".show()
			deselectAllSpells()
			$"../animationTotemDead".play("damagedWithFire")
		elif selectedSpellMagic == true and currentActions > 1 and isAtRange:
			var randomDamage = round(rng.randf_range(2, 5))
			$"../totem".actualHp = $"../totem".actualHp - randomDamage
			$"../totem/Label".text = str($"../totem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellMagic = false
			actualizarHudAcciones()
			$"../totem/damageLog".text = "[color=#c71ef5]-" + str(randomDamage) + "[/color]"
			$"../totem/damageLog".show()
			deselectAllSpells()
			$"../animationTotemDead".play("damagedWithMage")
		elif selectedSpellIce == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../totem".actualHp = $"../totem".actualHp - randomDamage
			$"../totem/Label".text = str($"../totem".actualHp) + "/12"
			currentActions = currentActions -2
			selectedSpellIce = false
			actualizarHudAcciones()
			$"../totem/damageLog".text = "[color=#1195e0]-" + str(randomDamage) + "[/color]"
			$"../totem/damageLog".show()
			deselectAllSpells()
			$"../animationTotemDead".play("damagedWithIce")
		elif selectedSpellInstaKill == true and currentActions > 4:
			var randomDamage = 0
			$"../totem".actualHp = $"../totem".actualHp - randomDamage
			$"../totem/Label".text = str($"../totem".actualHp) + "/12"
			currentActions = currentActions -5
			selectedSpellInstaKill = false
			actualizarHudAcciones()
			$"../totem/damageLog".text = "[i][color=#c80c64]Inmune[/color][/i]"
			$"../totem/damageLog".show()
			deselectAllSpells()
	
	CITspells()
	
	if $"../totem".actualHp < 1:
		$"../animationTotemDead".play("totemDead")
		$"../totem".queue_free()
		totemsDestroyed = totemsDestroyed +1
		isTotemDead = true
	
	if totemsDestroyed > 2:
		$"../warlock".isKilleable = true

func CITspells():
	if currentActions < 2:
		$"../spellInstaKill/CITinstaKill".show()
		$"../spellHeal/CITheal".show()
		$"../spellMovement/CITmovement".show()
		$"../spellFire/CITfire".show()
		$"../spellMagic/CITmagic".show()
		$"../spellIce/CITice".show()
	elif currentActions < 3:
		$"../spellInstaKill/CITinstaKill".show()
		$"../spellHeal/CITheal".show()
		$"../spellMovement/CITmovement".show()
	elif currentActions < 4:
		$"../spellInstaKill/CITinstaKill".show()
	else:
		$"../spellInstaKill/CITinstaKill".hide()
		$"../spellHeal/CITheal".hide()
		$"../spellMovement/CITmovement".hide()
		$"../spellFire/CITfire".hide()
		$"../spellMagic/CITmagic".hide()
		$"../spellIce/CITice".hide()
	
	if cdSpellHeal > 0:
		$"../spellHeal/CITheal".show()
	
	if cdSpellMovement > 0:
		$"../spellMovement/CITmovement".show()
	
func _on_warlock_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var isAtRange = false
		if $"../warlock".position.distance_to($".".position) < 55:
			isAtRange = true
		
		if selectedSpellFire == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../warlock".actualHp = $"../warlock".actualHp - randomDamage
			$"../warlock/Label".text = str($"../warlock".actualHp) + "/1"
			currentActions = currentActions -2
			selectedSpellFire = false
			actualizarHudAcciones()
			$"../warlock/damageLog".text = "[color=#ee2d27]-" + str(randomDamage) + "[/color]"
			$"../warlock/damageLog".show()
			deselectAllSpells()
		elif selectedSpellMagic == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../warlock".actualHp = $"../warlock".actualHp - randomDamage
			$"../warlock/Label".text = str($"../warlock".actualHp) + "/1"
			currentActions = currentActions -2
			selectedSpellMagic = false
			actualizarHudAcciones()
			$"../warlock/damageLog".text = "[color=#c71ef5]-" + str(randomDamage) + "[/color]"
			$"../warlock/damageLog".show()
			deselectAllSpells()
		elif selectedSpellIce == true and currentActions > 1 and isAtRange:
			var randomDamage = 0
			$"../warlock".actualHp = $"../warlock".actualHp - randomDamage
			$"../warlock/Label".text = str($"../warlock".actualHp) + "/1"
			currentActions = currentActions -2
			selectedSpellIce = false
			actualizarHudAcciones()
			$"../warlock/damageLog".text = "[color=#1195e0]-" + str(randomDamage) + "[/color]"
			$"../warlock/damageLog".show()
			deselectAllSpells()
		elif selectedSpellInstaKill == true and currentActions > 4:
			currentActions = currentActions -5
			selectedSpellInstaKill = false
			actualizarHudAcciones()
			deselectAllSpells()
			
			if $"../warlock".isKilleable == true:
				$"../warlock".queue_free()
				winCondition = true
				$"../finalSceneLayer".show()
				$"../finalBackground".show()
				$"../finalSceneLayer/combatWin".text = "[center][b]¡ Thanks 4 playing ![/b][/center]"
			elif $"../warlock".isKilleable == false:
				$"../warlock/damageLog".text = "[i][color=#c80c64]Inmune[/color][/i]"
				$"../warlock/damageLog".show()
