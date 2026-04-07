package data.domain.systems;

import common.struct.Coordinate;
import echoes.View;
import data.domain.components.Velocity;
import data.domain.components.Position;
import core.MainLoop;
import echoes.System;

class MovementSystem extends System {
	public var loop(get, never): MainLoop;

	@:update private function updatePosition(position: Position, velocity: Velocity, time: Float): Void {
		position.x += velocity.x * time;
		position.y += velocity.y * time;

		// TODO This appears to be the culprit - the time value is not smooth frame-to-frame.
		trace(new Coordinate(velocity.x * time, velocity.y * time, PIXEL).toString());
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
