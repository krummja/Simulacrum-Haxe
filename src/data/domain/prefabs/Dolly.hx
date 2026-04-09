package data.domain.prefabs;

import echoes.Entity;
import data.domain.components.Position;
import data.domain.components.Camera;

@:build(echoes.Entity.build())
abstract Dolly(Entity) {
	public var position: Position;
	public var camera: Camera;
}
