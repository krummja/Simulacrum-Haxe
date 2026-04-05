package data.domain.components;

import core.RenderLayerManager.RenderLayerType;
import core.RenderLayer;
import h2d.Tile;
import h2d.Bitmap;
import data.TileKey;
import data.domain.components.Display;

class Sprite extends Display {
	public var tileKey(default, set): TileKey;
	public var ob(default, null): Bitmap;
	public var tile(get, never): Tile;
	public var layer(default, null): RenderLayerType;

	public function new(tileKey: TileKey, primary: ColorKey = C_WHITE, secondary: ColorKey = C_BLACK, layer: RenderLayerType = OBJECT) {
		this.tileKey = tileKey;
		this.layer = layer;
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
