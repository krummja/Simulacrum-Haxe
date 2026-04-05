package data.scenes;

import common.struct.Coordinate;
import core.Command;
import core.Frame;
import core.Scene;
import data.scenes.settings_scene.SettingsScene;

class TestScene extends Scene {
	public function new() {}

	private override function onEnter(): Void {
		loop.world.initialize();

		for (x in 0...100) {
			for (y in 0...100) {
				loop.world.spawner.spawn(FLOOR, new Coordinate(x * 16, y * 16, WORLD));
			}
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
	}

	private override function onDestroy(): Void {}
}
