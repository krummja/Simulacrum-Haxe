package data.domain.terrain;

import data.domain.terrain.TerrainType;
import data.TileKey;

typedef Cell = {
	idx: Int,
	terrain: TerrainType,
	tileKey: TileKey,
	primary: Int,
	secondary: Int,
	background: Int,
};
