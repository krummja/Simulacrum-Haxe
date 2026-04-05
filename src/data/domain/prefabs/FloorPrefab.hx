package data.domain.prefabs;

import common.struct.Coordinate;
import echoes.Entity;
import data.domain.components.Sprite;
import data.domain.components.Position;

@:build(echoes.Entity.build())
@:arguments(Position)
abstract Floor(Entity) {
	public var sprite: Sprite = new Sprite(TK_GRASS_1, C_RED_3, C_GREEN_5, GROUND);
	public var position: Position;
}
