package data.domain.prefabs;

import echoes.Entity;
import data.domain.components.Sprite;
import data.domain.components.Position;

@:build(echoes.Entity.build())
@:arguments(Position)
abstract Floor(Entity) {
	public var sprite: Sprite = new Sprite(TK_GRASS_1, C_GREEN_1, C_GREEN_2, GROUND);
	public var position: Position;
}
