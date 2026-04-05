package data;

import data.domain.World;
import echoes.Entity;
import common.struct.Coordinate;
import data.domain.components.Position;
import data.domain.prefabs.PlayerPrefab;

class PlayerManager {
	public var entity(default, null): Entity;

	public var x(get, set): Float;
	public var y(get, set): Float;
	public var pos(get, set): Coordinate;

	private var world(default, null): World;

	public function new(world: World) {
		this.world = world;
	}

	public function create(pos: Coordinate) {
		entity = new Player(new Position(pos.x, pos.y));
	}

	private inline function get_x(): Float {
		var position = this.entity.get(Position);
		if (position == null) return 0.0;
		return position.x;
	}

	private inline function get_y(): Float {
		var position = this.entity.get(Position);
		if (position == null) return 0.0;
		return position.y;
	}

	private inline function get_pos(): Coordinate {
		return new Coordinate(this.x, this.y, WORLD);
	}

	private inline function set_x(value: Float): Float {
		this.entity.get(Position).setPosition(value, this.y);
		return value;
	}

	private inline function set_y(value: Float): Float {
		this.entity.get(Position).setPosition(this.x, value);
		return value;
	}

	private inline function set_pos(value: Coordinate): Coordinate {
		this.entity.get(Position).setPosition(value.x, value.y);
		return value;
	}
}
