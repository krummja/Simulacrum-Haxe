package data.scenes;

import core.Frame;
import core.KeyCode;
import core.Scene;

class TestScene extends Scene {
	private var title: h2d.Text;

	public function new() {}

	private override function onEnter(): Void {
		this.title = new h2d.Text(hxd.Res.fnt.bizcat.toFont());
		this.title.setScale(3);
		this.title.text = "Simulacrum";
		this.title.color = new h3d.Vector4(1, 1, 0.9);

		this.loop.render(HUD, this.title);
	}

	private override function update(frame: Frame): Void {
		this.title.textAlign = Center;
		var width = this.loop.window.width;
		var height = this.loop.window.height;

		this.title.x = width / 2;
		this.title.y = height / 2;
	}

	private override function onDestroy(): Void {
		this.title.remove();
	}
}
