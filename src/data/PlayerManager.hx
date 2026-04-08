package data;

import core.MainLoop;
import core.Input2D;
import common.struct.IntPoint;
import h3d.Vector;
import data.domain.World;
import common.struct.Coordinate;
import data.domain.components.*;
import data.domain.prefabs.*;

class PlayerManager {
	public var entity(default, null): Player;
	public var x(get, null): Float;
	public var y(get, null): Float;
	public var pos(get, null): Coordinate;

	public var input(default, null): Input2D;

	private var world(default, null): World;

	public function new(world: World) {
		this.world = world;
		this.input = new Input2D(false);
	}

	public function create(pos: Coordinate) {
		entity = new Player(new Position(pos.x, pos.y));
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
}
