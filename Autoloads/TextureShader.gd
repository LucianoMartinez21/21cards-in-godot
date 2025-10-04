extends Node

@onready var ShaderDictionary: Dictionary = {
	"Shining" : "res://Shaders/Shining.gdshader",
	"Blinking": "res://Shaders/Blinking.gdshader"
}

func ApplyShader(Object, shader: String):
	var ShaderMaterialObj: ShaderMaterial = ShaderMaterial.new()
	ShaderMaterialObj.shader = load(ShaderDictionary[shader])
	Object.material = ShaderMaterialObj
	pass
	
func UnapplyShader(Object: Node2D):
	Object.material = null
	pass
