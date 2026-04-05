package data.scenes.settings_scene;

import core.KeyCode;
import core.Scene;
import core.Frame;
import core.Command;
import data.scenes.settings_scene.SettingsUI;

class SettingsScene extends Scene {
	public var dirty(default, null): Bool = false;

	private var ui: SettingsUI;

	public function new() {
		ui = new SettingsUI(this);
	}

	private override function onEnter(): Void {
		loop.render(HUD, ui);
	}

	private function handleInput(command: Command) {
		switch (command.type) {
			case _:
		}
	}

	private override function onKeyDown(key: KeyCode) {
		if (key == KEY_W) {
			dirty = !dirty;
			trace(dirty);
		}
	}

	private override function update(frame: Frame): Void {
		var cmd = loop.commands.peek();
		if (cmd != null) {
			handleInput(loop.commands.next());
		}

		ui.update();
	}

	private override function onDestroy(): Void {
		ui.remove();
	}
}
