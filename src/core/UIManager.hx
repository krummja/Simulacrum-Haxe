package core;

import ui.Test;
import ui.XYMetric;
import common.struct.Coordinate;
import haxe.ui.core.ItemRenderer;
import haxe.ui.core.Screen;
import haxe.ui.*;
import haxe.ui.containers.*;
import haxe.ui.components.*;
import haxe.ui.data.*;

@:xml('
<vbox width="100%" height="100%" style="padding: 10px">
	<hbox styleName="texturedRect" id="wrapper" width="100%" height="100%">
		<vbox id="metrics" width="100%" horizontalAlign="right">
			<label id="fps" text="FPS" style="color:#ffffff;" horizontalAlign="right" />
		</vbox>
	</hbox>
</vbox>
')
class UIRoot extends Box {
	var mousePos: XYMetric;
	var playerPos: XYMetric;
	var cameraPos: XYMetric;

	public function new(width: Float, height: Float) {
		super();
		wrapper.width = width;
		wrapper.height = height;

		fps.text = 'FPS: ${UIManager.fps}';

		mousePos = new XYMetric("Mouse", "0", "0");
		playerPos = new XYMetric("Player", "0", "0");
		cameraPos = new XYMetric("Camera", "0", "0");
		metrics.addComponent(mousePos);
		metrics.addComponent(playerPos);
		metrics.addComponent(cameraPos);
	}

	public function update() {
		fps.text = 'FPS: ${UIManager.fps}';
		mousePos.update(UIManager.mousePos.x, UIManager.mousePos.y);
		playerPos.update(UIManager.playerPos.x, UIManager.playerPos.y);
		cameraPos.update(UIManager.cameraPos.x, UIManager.cameraPos.y);
	}
}

class UIManager {
	public static var overlay_root: UIRoot;
	public static var ui_root: UIRoot;
	public static var fps: Float = 0.0;
	public static var mousePos: Coordinate;
	public static var playerPos: Coordinate;
	public static var cameraPos: Coordinate;

	public var loop(default, null): MainLoop;

	public function new(loop: MainLoop) {
		this.loop = loop;
		Toolkit.init({root: this.loop.layers.root});

		UIManager.ui_root = new UIRoot(this.loop.window.width, this.loop.window.height);
		this.loop.layers.render(HUD, UIManager.ui_root);
	}

	public function update(frame: core.Frame) {
		UIManager.fps = Math.fround(frame.smoothFps);
		UIManager.mousePos = loop.input.mouse;
		UIManager.playerPos = loop.world.player.pos;
		UIManager.cameraPos = loop.camera.pos;
		ui_root.update();
	}
}
