package common.util;

import haxe.Unserializer;
import haxe.Serializer;

class Serial {
	public static function serialize(value: Dynamic): String {
		var ser = new Serializer();
		ser.useCache = true;
		ser.serialize(value);
		return ser.toString();
	}

	public static function deserialize<T>(serialized: String): T {
		var uns = new Unserializer(serialized);
		var value = uns.unserialize();
		return value;
	}
}
