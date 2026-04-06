package data;

import h3d.Vector;
import data.domain.World;
import common.struct.Coordinate;
import data.domain.components.*;
import data.domain.prefabs.*;

class PlayerManager {
	public var entity(default, null): Player;

	public var x(get, set): Float;
	public var y(get, set): Float;
	public var pos(get, set): Coordinate;
	public var speed(get, set): Int;

	private var world(default, null): World;

	public function new(world: World) {
		this.world = world;
	}

	public function create(pos: Coordinate) {
		entity = new Player(new Position(pos.x, pos.y));
	}

	public function move(direction: Vector, dt: Float) {
		direction.normalize();
		this.x += direction.x * speed * dt;
		this.y += direction.y * speed * dt;
	}

	private inline function get_x(): Float {
		return entity.position.x;
	}

	private inline function get_y(): Float {
		return entity.position.y;
	}

	private inline function get_pos(): Coordinate {
		return new Coordinate(this.x, this.y, WORLD);
	}

	private inline function set_x(value: Float): Float {
		entity.position.x = value;
		return value;
	}

	private inline function set_y(value: Float): Float {
		entity.position.y = value;
		return value;
	}

	private inline function set_pos(value: Coordinate): Coordinate {
		entity.position.x = value.x;
		entity.position.y = value.y;
		return value;
	}

	private inline function get_speed(): Int {
		return entity.speed;
	}

	private inline function set_speed(value: Int): Int {
		entity.speed = value;
		return value;
	}
}
