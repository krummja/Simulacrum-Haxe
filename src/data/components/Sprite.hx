package data.components;

import h2d.Tile;
import h2d.Bitmap;
import data.TileKey;
import data.components.Display;

class Sprite extends Display {
	public var tileKey(default, set): TileKey;
	public var ob(default, null): Bitmap;
	public var tile(get, never): Tile;

	public function new(tileKey: TileKey) {
		this.tileKey = tileKey;
		ob = new Bitmap(this.tile);
		ob.color = new h3d.Vector4(1, 0, 0, 1);
		ob.setScale(2);
	}

	private function get_tile(): Tile {
		return TileResources.get(tileKey);
	}

	private function set_tileKey(value: TileKey): TileKey {
		tileKey = value;
		if (ob != null) {
			ob.tile = tile;
		}
		return value;
	}

	private function getDrawable(): h2d.Drawable {
		return ob;
	}
}
