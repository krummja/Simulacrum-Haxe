package data.domain.prefabs;

import echoes.Entity;
import common.struct.Coordinate;

enum SpawnableType {
	PLAYER;
	FLOOR;
	WALL;
}

class Spawner {
	public var prefabs(default, null): Map<SpawnableType, Prefab>;

	public function new() {
		this.prefabs = new Map();
	}

	public function initialize() {
		this.prefabs.set(PLAYER, new PlayerPrefab());
		this.prefabs.set(FLOOR, new FloorPrefab());
	}

	public function spawn(type: SpawnableType, ?pos: Coordinate, ?options: Dynamic): Entity {
		var p = pos == null ? new Coordinate(0, 0, WORLD) : pos.toWorld().floor();
		var o = options == null ? {} : options;
		var entityType = this.prefabs.get(type);
		var entity = entityType.create(o, p);
		return entity;
	}
}
