package data.domain.prefabs;

import echoes.Entity;
import common.struct.Coordinate;
import data.domain.components.Sprite;
import data.domain.components.IsPlayer;
import data.domain.components.Position;
import data.domain.components.Moniker;

class PlayerPrefab extends Prefab {
	public function create(options: Dynamic, pos: Coordinate): Entity {
		var entity = new Entity();

		entity.add(new Sprite(PLAYER_1, C_YELLOW_0, C_BLUE_4, ACTOR));
		entity.add(new IsPlayer());
		entity.add(new Position(10, 10));
		entity.add(new Moniker("Player"));

		return entity;
	}
}
