package common.util;

import format.png.Tools;

typedef DecodedImage = {
	var decodedBytes: haxe.io.Bytes;
	var width: Int;
	var height: Int;
}

class ImageDecoder {
	public static var lastError: Null<String>;

	public static function decode(fileContent: haxe.io.Bytes): Null<DecodedImage> {
		lastError = null;

		return try switch Identify.getType(fileContent) {
			case Png:
				decodePng(fileContent);
			case _:
				null;
		}
		catch (err: String) {
			lastError = err;
			return null;
		}
	}

	public static function decodePixels(fileContent: haxe.io.Bytes): Null<hxd.Pixels> {
		var img = decode(fileContent);
		return img == null ? null : new hxd.Pixels(img.width, img.height, img.decodedBytes, BGRA);
	}

	private static function decodePng(b: haxe.io.Bytes): Null<DecodedImage> {
		try {
			var i = new haxe.io.BytesInput(b);
			var reader = new format.png.Reader(i);
			var data = reader.read();

			var width = 0;
			var height = 0;
			for (e in data) {
				switch e {
					case CHeader(h):
						width = h.width;
						height = h.height;
					case _:
				}

				for (e in data) {
					switch e {
						case CData(bytes):
							var dst = haxe.io.Bytes.alloc(width * height * 4);
							Tools.extract32(data, dst, false);

							return {
								width: width,
								height: height,
								decodedBytes: dst,
							};
						case _:
					}
				}
			}
		}
		catch (e: Dynamic) {
			throw "Failed to read PNG, err=" + e;
		}

		return null;
	}
}
