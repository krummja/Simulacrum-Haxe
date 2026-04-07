package data.domain.systems;

import echoes.System;
import common.struct.Coordinate;
import data.domain.components.Velocity;
import data.domain.components.Position;
import data.domain.components.IsMovable;
import core.Projection;
import core.MainLoop;

class MovementSystem extends System {
	public var loop(get, never): MainLoop;

	private var smoothingSpeed: Float = 1.0;

	@:update private function updatePosition(position: Position, velocity: Velocity, movable: IsMovable, time: Float): Void {
		// var currentPosition = position.asCoordinate();

		// position.x += velocity.x * time;
		// position.y += velocity.y * time;
		position.update(velocity.x * time, velocity.y * time);

		// var targetPosition = new Coordinate(targetX, targetY, WORLD);
		// var newPosition = currentPosition.lerp(targetPosition, time);

		// position.x = targetX;
		// position.y = targetY;
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
