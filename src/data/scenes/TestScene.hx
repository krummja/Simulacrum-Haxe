package data.scenes;

import core.Projection;
import core.MainLoop;
import hxd.Window;
import h2d.Bitmap;
import common.struct.Coordinate;
import h3d.Vector;
import core.Command;
import core.Frame;
import core.Scene;
import data.scenes.settings_scene.SettingsScene;

class DebugCrosshair extends h2d.Object {
	public var loop(get, null): MainLoop;
	public var pos(get, set): Coordinate;

	public function new() {
		super();

		// var bm = new Bitmap(DebugResources.get(5, 1));
		// bm.color = 0xff0000.toHxdColor();
		// addChild(bm);

		loop.layers.render(HUD, this);
	}

	public function update() {
		var mp = loop.input.mouse;
		pos = mp;
	}

	private function get_pos(): Coordinate {
		// var size = getSize();
		// var w = size.width;
		// var h = size.height;
		// var sw = Window.getInstance().width;
		// var sh = Window.getInstance().height;
		// setPosition((sw / 2) - w, (sh / 2) - h);
		return new Coordinate(x, y, SCREEN);
	}

	private function set_pos(value: Coordinate): Coordinate {
		var sp = value.toScreen();
		var size = getSize();
		setPosition(sp.x - (size.width / 2), sp.y - (size.height / 2));
		return value;
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}

class TestScene extends Scene {
	private var debugCrosshair: DebugCrosshair;

	public function new() {}

	private override function onEnter(): Void {
		loop.world.initialize();
		loop.world.start();

		var cfocus = loop.camera.focus.toWorld().toFloatPoint();
		var ctarget = loop.world.player.pos.toFloatPoint();
		loop.camera.focus = cfocus.lerp(ctarget, 0.4).asWorld();

		debugCrosshair = new DebugCrosshair();
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
		var cfocus = loop.camera.focus.toWorld().toFloatPoint();
		var ctarget = loop.world.player.pos.toFloatPoint();
		loop.camera.focus = cfocus.lerp(ctarget, 0.2).asWorld();

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
		loop.world.update();
	}

	private function drawDebug() {
		debugCrosshair.update();

		// var g = new h2d.Graphics(loop.layers.screen);
		// g.lineStyle(1, 0xFF0000);
		// g.drawRect(10, 10, 10, 10);
		// g.endFill();
	}

	private override function onDestroy(): Void {}
}
