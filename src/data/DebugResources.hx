package data;

import h2d.Tile;

class DebugResources {
	public static var tiles: Array<Array<Tile>>;

	public static function get(x: Int, y: Int): Tile {
		if (x > 20 || y > 10) return null;
		return tiles[y][x];
	}

	public static function init() {
		var sheet = hxd.Res.tiles.crosshairs;
		tiles = sheet.toTile().divide(20, 10);
	}
}
