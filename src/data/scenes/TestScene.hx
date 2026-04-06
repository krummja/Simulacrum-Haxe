package data.scenes;

import common.struct.Coordinate;
import h3d.Vector;
import core.Command;
import core.Frame;
import core.Scene;
import data.scenes.settings_scene.SettingsScene;

class TestScene extends Scene {
	public function new() {}

	private override function onEnter(): Void {
		loop.world.initialize();
		loop.world.start();
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
		loop.world.update();

		// var cfocus = loop.camera.focus.toWorld().toFloatPoint();
		// var ctarget = loop.world.player.pos.toFloatPoint();
		// loop.camera.focus = cfocus.lerp(ctarget, 0.2).asWorld();

		loop.camera.pos = loop.world.player.pos.toWorld();

		var cmd = loop.commands.peek();
		if (cmd != null) {
			handleInput(loop.commands.next());
		}

		var direction = new Vector(0, 0);

		if (hxd.Key.isDown(hxd.Key.W)) {
			direction.y = -1;
		}
		if (hxd.Key.isDown(hxd.Key.A)) {
			direction.x = -1;
		}
		if (hxd.Key.isDown(hxd.Key.S)) {
			direction.y = 1;
		}
		if (hxd.Key.isDown(hxd.Key.D)) {
			direction.x = 1;
		}

		loop.world.player.move(direction, frame.dt);
	}

	private override function onDestroy(): Void {}
}
