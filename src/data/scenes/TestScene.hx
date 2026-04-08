package data.scenes;

import hxd.Window;
import h2d.Bitmap;
import h3d.Vector;
import common.struct.Cardinal;
import common.struct.IntPoint;
import core.Projection;
import core.MainLoop;
import core.Command;
import core.Frame;
import core.Scene;
import common.struct.Coordinate;
import data.scenes.settings_scene.SettingsScene;
import data.domain.components.Move;

class DebugCrosshair extends h2d.Object {
	public var loop(get, null): MainLoop;
	public var pos(get, set): Coordinate;

	public function new() {
		super();

		var bm = new Bitmap(DebugResources.get(5, 1));
		bm.color = 0xff0000.toHxdColor();
		addChild(bm);

		loop.layers.render(HUD, this);
	}

	public function update() {
		var mp = loop.input.mouse;
		pos = mp;
	}

	private function get_pos(): Coordinate {
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
	public function new() {}

	private override function onEnter(): Void {
		loop.world.initialize();
		loop.world.start();

		var cfocus = loop.camera.focus.toWorld().toFloatPoint();
		var ctarget = loop.world.player.pos.toFloatPoint();
		loop.camera.focus = cfocus.lerp(ctarget, 0.2).asWorld();
	}

	private function handleInput(command: Command) {
		switch (command.type) {
			case CMD_CONSOLE:
				loop.scenes.push(new Console());
			case CMD_CANCEL:
				loop.scenes.push(new SettingsScene());
			case CMD_MOVE_N:
				this.move(NORTH);
			case CMD_MOVE_S:
				this.move(SOUTH);
			case CMD_MOVE_E:
				this.move(EAST);
			case CMD_MOVE_W:
				this.move(WEST);
			case _:
		}
	}

	private override function update(frame: Frame): Void {
		// var cfocus = loop.camera.focus.toWorld().toFloatPoint();
		// var ctarget = loop.world.player.pos.toWorld().toFloatPoint();
		// loop.camera.focus = cfocus.lerp(ctarget, 0.2).asWorld();

		var cmd = loop.commands.peek();
		if (cmd != null) {
			handleInput(loop.commands.next());
		}

		loop.world.update();
	}

	private override function onDestroy(): Void {}

	private function isKeyboardDownFast(k: Int) {
		return hxd.Key.isDown(k);
	}

	private function move(direction: Cardinal): Void {
		var target = loop.world.player.pos.toIntPoint().add(direction.toOffset());
		var move = new Move(target.asWorld(), 1.0, EASE_LINEAR);
		move.start = loop.world.player.pos;
		move.startTime = MainLoop.getInstance().frame.elapsed;
		loop.world.player.entity.add(move);
	}
}
