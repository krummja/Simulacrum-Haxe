package data.scenes;

import common.struct.Cardinal;
import data.domain.components.Move;
import core.Frame;
import core.KeyCode;
import core.Scene;
import common.struct.Coordinate;

class TestScene extends Scene {
	public function new() {}

	private override function onEnter(): Void {
		loop.world.initialize();
		loop.world.start();
	}

	private override function update(?frame: Frame): Void {
		loop.world.update();
		handleInput();
	}

	private function handleInput(): Void {
		if (!loop.world.player.entity.exists(Move)) {
			var heldDir = getHeldDirection();
			if (heldDir != null) {
				loop.input.flush();
				move(heldDir);
			} else {
				var cmd = loop.commands.next();
				if (cmd != null) {
					// handle
				}
			}
		} else {
			// Drain a queued event per frame to prevent buildup
			loop.commands.next();
		}
	}

	private function move(direction: Cardinal) {
		if (loop.world.player.entity.exists(Move)) {
			return;
		}

		var target = loop.world.player.pos.toIntPoint().add(direction.toOffset());
		var timeoutId = '${loop.world.player.entity.id}-move';
		var moveTimer = loop.timeout.start(timeoutId, 0.15, false);

		var move = new Move(target.asWorld(), moveTimer.duration, EASE_LINEAR);
		move.start = loop.world.player.pos;
		move.startTime = loop.frame.elapsed;
		loop.world.player.entity.add(move);
	}

	private function getHeldDirection(): Null<Cardinal> {
		if (hxd.Key.isDown(KEY_UP) || hxd.Key.isDown(KEY_W)) return NORTH;
		if (hxd.Key.isDown(KEY_DOWN) || hxd.Key.isDown(KEY_X)) return SOUTH;
		if (hxd.Key.isDown(KEY_RIGHT) || hxd.Key.isDown(KEY_D)) return EAST;
		if (hxd.Key.isDown(KEY_LEFT) || hxd.Key.isDown(KEY_A)) return WEST;
		return null;
	}
}
