package data.scenes;

import haxe.ui.containers.Box;
import core.Scene;
import core.Frame;
import core.Command;

@:xml('
    <vbox width="100%" height="100%" style="padding: 10px; background-color: #ff0000;">
        <label text="Settings" style="color: #ffffff;" />
    </vbox>
')
class SettingsPanel extends Box {
	public function new() {
		super();
	}
}

class SettingsScene extends Scene {
	public function new() {}

	private override function onEnter(): Void {
		loop.render(HUD, new SettingsPanel());
	}

	private function handleInput(command: Command) {
		switch (command.type) {
			case CMD_CANCEL:
				loop.scenes.pop();
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
