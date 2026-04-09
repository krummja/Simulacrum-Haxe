package data;

import h2d.Tile;

class TileResources {
	public static var tiles: Map<TileKey, Tile> = [];

	public static function get(key: TileKey): Tile {
		if (key.isNull()) return null;
		var tile = tiles.get(key);

		if (tile.isNull()) return tiles.get(TK_UNKNOWN);
		return tile;
	}

	public static function init() {
		TileResources.initOverworld();
		TileResources.initPlayer();
	}

	public static function initOverworld() {
		var sheet = hxd.Res.tiles.kenny2;
		var t = sheet.toTile().divide(49, 22);

		tiles.set(TK_UNKNOWN, t[0][0]);

		tiles.set(TK_STONES_1, t[0][1]);
		tiles.set(TK_STONES_2, t[0][2]);
		tiles.set(TK_STONES_3, t[0][3]);
		tiles.set(TK_STONES_4, t[0][4]);

		tiles.set(TK_GRASS_1, t[0][5]);
		tiles.set(TK_GRASS_2, t[0][6]);
		tiles.set(TK_GRASS_3, t[0][7]);
		tiles.set(TK_GRASS_4, t[2][0]);

		tiles.set(TK_TREE_1, t[1][0]);
		tiles.set(TK_TREE_2, t[1][1]);
		tiles.set(TK_TREE_3, t[1][2]);
		tiles.set(TK_TREE_4, t[1][3]);
		tiles.set(TK_TREE_5, t[1][4]);
		tiles.set(TK_TREE_6, t[1][5]);
		tiles.set(TK_TREE_7, t[2][3]);
		tiles.set(TK_TREE_8, t[2][4]);

		tiles.set(TK_ROCKS_1, t[2][5]);
		tiles.set(PLAYER_1, t[0][25]);
	}

	public static function initPlayer() {
		var sheet = hxd.Res.tiles.test_overworld;
		var t = sheet.toTile().divide(12, 32);

		// Standing
		tiles.set(PLAYER_S_STAND, t[0][0]);
		tiles.set(PLAYER_N_STAND, t[0][1]);
		tiles.set(PLAYER_W_STAND, t[0][2]);
		tiles.set(PLAYER_E_STAND, t[0][3]);

		// Running
		tiles.set(PLAYER_S_RUN_0, t[0][4]);
		tiles.set(PLAYER_S_RUN_1, t[0][5]);
		tiles.set(PLAYER_N_RUN_0, t[0][6]);
		tiles.set(PLAYER_N_RUN_1, t[0][7]);
		tiles.set(PLAYER_W_RUN, t[0][8]);
		tiles.set(PLAYER_E_RUN, t[0][9]);
	}

	public static function initDebug() {
		var sheet = hxd.Res.tiles.crosshairs;
		var t = sheet.toTile().divide(20, 10);

		tiles.set(CROSSHAIRS, t[5][1]);
	}
}
