package data.domain.systems;

import common.util.Easing;
import echoes.Entity;
import echoes.System;
import core.MainLoop;
import data.domain.components.*;

class MovementSystem extends System {
	@:update private function updatePosition(entity: Entity, position: Position, move: Move): Void {
		var timeoutId = '${entity.id}-move';
		var moveTimer = MainLoop.getInstance().timeout.get(timeoutId);

		if (moveTimer == null || moveTimer.isComplete) {
			var target = move.goal.toWorld();
			position.set(target.x, target.y);
			entity.remove(move);
			return;
		}

		var start = move.start.toWorld();
		var target = move.goal.toWorld();
		var progress = Easing.apply(moveTimer.progress, move.easing);
		var newPos = start.lerp(target, progress);

		position.set(newPos.x, newPos.y);
	}
}
