package data.domain.prefabs;

import common.struct.Coordinate;
import echoes.Entity;
import data.domain.components.Sprite;
import data.domain.components.Position;

class FloorPrefab extends Prefab {
	public function create(options: Dynamic, pos: Coordinate): Entity {
		var entity = new Entity();

		entity.add(new Sprite(TK_GRASS_1, C_GREEN_3, C_GREEN_5, GROUND));
		entity.add(new Position(pos.x, pos.y));

		return entity;
	}
}
