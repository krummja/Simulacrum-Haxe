package core;

import hxd.Window;
import ui.Test;
import ui.XYMetric;
import common.struct.Coordinate;
import haxe.ui.core.ItemRenderer;
import haxe.ui.core.Screen;
import haxe.ui.*;
import haxe.ui.containers.*;
import haxe.ui.components.*;
import haxe.ui.data.*;

typedef Metric = {name: String, component: XYMetric};

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
	var metric_components(default, null): Map<String, XYMetric>;

	public function new(width: Float, height: Float) {
		super();
		wrapper.width = width;
		wrapper.height = height;

		metric_components = [];

		fps.text = 'FPS: ${UIManager.fps}';

		for (reportable in UIManager.reportables) {
			var comp = new XYMetric(reportable.name, "0", "0");
			metric_components[reportable.name] = comp;
			metrics.addComponent(comp);
		}
	}

	public function update() {
		fps.text = 'FPS: ${UIManager.fps}';

		for (reportable in UIManager.reportables) {
			var comp = metric_components.get(reportable.name);
			comp.update(reportable.coord.x, reportable.coord.y);
		}
	}
}

typedef Reportable = {name: String, coord: Coordinate, updater: () -> Coordinate};

class UIManager {
	public static var overlay_root: UIRoot;
	public static var ui_root: UIRoot;
	public static var fps: Float = 0.0;

	public static var reportables(default, null): Array<Reportable>;
	public static var mousePos: Coordinate;
	public static var playerPos: Coordinate;
	public static var cameraPos: Coordinate;

	public var loop(default, null): MainLoop;

	public function new(loop: MainLoop) {
		this.loop = loop;
		Toolkit.init({root: this.loop.layers.root});

		UIManager.reportables = [];

		// addReportable({
		// 	name: "Mouse",
		// 	coord: new Coordinate(0, 0, SCREEN),
		// 	updater: () -> {
		// 		return loop.input.mouse;
		// 	}
		// });

		addReportable({
			name: "Window",
			coord: new Coordinate(0, 0, PIXEL),
			updater: () -> {
				var w = Window.getInstance().width;
				var h = Window.getInstance().height;
				return new Coordinate(w, h, PIXEL);
			},
		});

		addReportable({
			name: "Player [WOR]",
			coord: new Coordinate(0, 0, WORLD),
			updater: () -> {
				return loop.world.player.pos;
			},
		});

		addReportable({
			name: "Player [PIX]",
			coord: new Coordinate(0, 0, PIXEL),
			updater: () -> {
				return loop.world.player.pos.toPixel();
			},
		});

		addReportable({
			name: "Camera [WOR]",
			coord: new Coordinate(0, 0, WORLD),
			updater: () -> {
				return loop.camera.pos.toWorld();
			},
		});

		addReportable({
			name: "Camera [PIX]",
			coord: new Coordinate(0, 0, PIXEL),
			updater: () -> {
				return loop.camera.pos.toPixel();
			},
		});

		UIManager.ui_root = new UIRoot(this.loop.window.width, this.loop.window.height);
		this.loop.layers.render(HUD, UIManager.ui_root);
	}

	public function addReportable(rep: Reportable): Void {
		reportables.push(rep);
	}

	public function update(frame: core.Frame) {
		UIManager.fps = Math.fround(frame.smoothFps);

		for (reportable in reportables) {
			reportable.coord = reportable.updater();
		}

		ui_root.update();
	}
}
