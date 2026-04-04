package common.util;

enum IdentifyFormat {
	Unknown;
	Png;
	Jpeg;
	Gif;
	Bmp;
	Aseprite;
}

private typedef FileHeader = {id: IdentifyFormat, ?skipBytes: Int, magic: Array<Int>};

class Identify {
	private static var headers: Array<FileHeader> = [
		{id: Png, magic: [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1a, 0x0A]},
		{id: Gif, magic: [0x47, 0x49, 0x46, 0x38, 0x37, 0x61]}, // Gif 87a
		{id: Gif, magic: [0x47, 0x49, 0x46, 0x38, 0x39, 0x61]}, // Gif 89a
		{id: Jpeg, magic: [0xFF, 0xD8, 0xFF]}, // Jpeg raw
		{id: Jpeg, magic: [0xFF, 0xD8, 0xFF, 0xDB]}, // Jpeg raw
		{id: Jpeg, magic: [0xFF, 0xD8, 0xFF, 0xE0, -1, -1, 0x4A, 0x46, 0x49, 0x46, 0x00, 0x01]}, // Jpeg JFIF
		{id: Jpeg, magic: [0xFF, 0xD8, 0xFF, 0xE1, -1, -1, 0x45, 0x78, 0x69, 0x66, 0x00, 0x00]}, // Jpeg EXIF
		{id: Aseprite, magic: [0xE0, 0xA5]},
		{id: Bmp, magic: [0x42, 0x4d]},
	];

	public static function getType(b: haxe.io.Bytes): IdentifyFormat {
		if (b == null) return Unknown;
		for (h in headers) {
			if (matchHeader(b, h)) {
				return h.id;
			}
		}
		return Unknown;
	}

	private static function matchHeader(b: haxe.io.Bytes, h: FileHeader) {
		var skip = h.skipBytes == null ? 0 : h.skipBytes;
		for (i in 0...h.magic.length) {
			if (i + skip >= b.length || h.magic[i] >= 0 && h.magic[i] != b.get(i + skip)) {
				return false;
			}
		}
		return true;
	}
}
