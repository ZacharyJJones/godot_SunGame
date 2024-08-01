class_name Utils

static func Serialize(object) -> Dictionary:
	var dict = inst_to_dict(object)
	# Filter out "node" and "path" weird/special variables
	var keys = dict.keys().filter(func(k): return k[0] == "@")
	for i in keys.size():
		dict.erase(keys[i])	
	return dict
	
