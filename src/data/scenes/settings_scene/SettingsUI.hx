package data.scenes.settings_scene;

import haxe.ui.events.MouseEvent;
import haxe.ui.containers.VBox;

@:build(haxe.ui.ComponentBuilder.build("./settings-ui.xml"))
class SettingsUI extends VBox {
	private var scene(default, null): SettingsScene;

	public function new(scene: SettingsScene) {
		super();
		this.scene = scene;

		saveButton.disabled = true;
	}

	@:bind(returnButton, MouseEvent.CLICK)
	public function onReturnClicked(_) {
		this.scene.loop.scenes.pop();
	}

	@:bind(saveButton, MouseEvent.CLICK)
	public function onSaveClicked(_) {}

	public function update() {
		// if (scene.dirty) {
		// 	if (saveButton.disabled) {
		// 		saveButton.disabled = false;
		// 	}
		// }
	}
}
