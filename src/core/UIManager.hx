package core;

import haxe.ui.geom.Slice9;
import haxe.ui.geom.Slice9.Slice9Rects;
import haxe.ui.core.ItemRenderer;
import haxe.ui.core.Screen;
import haxe.ui.*;
import haxe.ui.containers.*;
import haxe.ui.components.*;
import haxe.ui.data.*;

@:xml('
<vbox width="100%" height="100%" style="padding: 10px">
	<hbox styleName="texturedRect" id="wrapper" width="100%" height="100%">
		<label id="fps" text="FPS" style="color:#ffffff;" />
	</hbox>
</vbox>
')
class UIRoot extends Box {
	public function new(width: Float, height: Float) {
		super();
		wrapper.width = width;
		wrapper.height = height;

		fps.text = 'FPS: ${UIManager.fps}';
	}

	public function update() {
		fps.text = 'FPS: ${UIManager.fps}';
	}
}

class UIManager {
	public static var overlay_root: UIRoot;
	public static var ui_root: UIRoot;
	public static var fps: Float = 0.0;

	public var loop(default, null): MainLoop;

	public function new(loop: MainLoop) {
		this.loop = loop;
		Toolkit.init({root: this.loop.layers.root});

		UIManager.ui_root = new UIRoot(this.loop.window.width, this.loop.window.height);
		this.loop.layers.render(HUD, UIManager.ui_root);
	}

	public function update(frame: core.Frame) {
		UIManager.fps = Math.fround(frame.smoothFps);
		ui_root.update();
	}
}
