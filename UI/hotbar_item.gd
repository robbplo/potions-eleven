class_name HotbarItem extends Panel

@onready var icon: TextureRect = $CenterContainer/Icon
@onready var ammo_label: RichTextLabel = $AmmoLabel
@onready var key_label: RichTextLabel = $KeyLabel
@onready var inactive_cover: Panel = $InactiveCover

func set_potion(potion: PotionResource):
	set_texture(potion.ui_texture)
	set_ammo(potion.count)

func set_texture(texture: Texture2D):
	icon.texture = texture

func set_ammo(ammo: int):
	ammo_label.text = str(ammo)

func set_key(key: int):
	key_label.text = str(key)

func set_active(active: bool):
	inactive_cover.visible = not active
