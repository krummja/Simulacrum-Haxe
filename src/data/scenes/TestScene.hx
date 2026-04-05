package data.scenes;

import core.KeyCode;
import core.Projection;
import common.struct.Coordinate;
import core.Command;
import core.Frame;
import core.Scene;
import data.scenes.settings_scene.SettingsScene;
import data.domain.prefabs.FloorPrefab;
import data.domain.components.Position;

class TestScene extends Scene {
	public function new() {}

	private override function onEnter(): Void {
		loop.world.initialize();

		for (x in 0...40) {
			for (y in 0...40) {
				var pos = new Coordinate(x, y, WORLD);
				new Floor(new Position(pos.x, pos.y));
			}
		}

		loop.world.start();
	}

	private override function onMouseMove(pos: Coordinate, prev: Coordinate) {
		loop.mousePos = Projection.screenToWorld(pos.x, pos.y);
	}

	private override function onKeyDown(key: KeyCode) {
		switch (key) {
			case KEY_W:
				loop.world.player.y -= 1;
			case KEY_S:
				loop.world.player.y += 1;
			case KEY_A:
				loop.world.player.x -= 1;
			case KEY_D:
				loop.world.player.x += 1;
			case _:
		}
	}

	private function handleInput(command: Command) {
		switch (command.type) {
			case CMD_CONSOLE:
				loop.scenes.push(new Console());
			case CMD_CANCEL:
				loop.scenes.push(new SettingsScene());
			case _:
		}
	}

	private override function update(frame: Frame): Void {
		var cmd = loop.commands.peek();
		if (cmd != null) {
			handleInput(loop.commands.next());
		}

		loop.world.update();
	}

	private override function onDestroy(): Void {}
}
