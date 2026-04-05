package core;

import common.struct.Coordinate;
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
		<vbox width="100%" horizontalAlign="right">
			<label id="fps" text="FPS" style="color:#ffffff;" horizontalAlign="right" />
			<vbox width="100px" horizontalAlign="right">
				<hbox>
					<label text="x" style="color:#ffffff;" horizontalAlign="left" />
					<label id="mx" text="0" style="color:#ffffff" horizontalAlign="right" />
				</hbox>
				<hbox>
					<label text="y" style="color:#ffffff;" horizontalAlign="left" />
					<label id="my" text="0" style="color:#ffffff" horizontalAlign="right" />
				</hbox>
			</vbox>
		</vbox>
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
		mx.text = '${UIManager.mousePos.x.floor()}';
		my.text = '${UIManager.mousePos.y.floor()}';
	}
}

class UIManager {
	public static var overlay_root: UIRoot;
	public static var ui_root: UIRoot;
	public static var fps: Float = 0.0;
	public static var mousePos: Coordinate;

	public var loop(default, null): MainLoop;

	public function new(loop: MainLoop) {
		this.loop = loop;
		Toolkit.init({root: this.loop.layers.root});

		UIManager.ui_root = new UIRoot(this.loop.window.width, this.loop.window.height);
		this.loop.layers.render(HUD, UIManager.ui_root);
	}

	public function update(frame: core.Frame) {
		UIManager.fps = Math.fround(frame.smoothFps);
		UIManager.mousePos = loop.mousePos;
		ui_root.update();
	}
}
