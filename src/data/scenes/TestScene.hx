package data.scenes;

import core.Command;
import core.Frame;
import core.Scene;

class TestScene extends Scene {
	public function new() {}

	private override function onEnter(): Void {}

	private function handleInput(command: Command) {
		switch (command.type) {
			case CMD_CONSOLE:
				loop.scenes.push(new Console());
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
