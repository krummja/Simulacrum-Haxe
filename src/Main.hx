import hxd.Res;
import common.util.MathLib;
import core.MainLoop;
import data.Commands;
import data.scenes.TestScene;

class Debug {
	private var loop: MainLoop;
	private var fpsText: h2d.Text;

	public function new(loop: MainLoop) {
		this.loop = loop;
		this.fpsText = new h2d.Text(hxd.Res.fnt.bizcat.toFont());
		this.fpsText.setScale(1);
		this.loop.render(HUD, this.fpsText);
	}

	@:allow(Main)
	private function update(): Void {
		this.fpsText.textAlign = Left;
		this.fpsText.x = 4;
		this.fpsText.y = 4;
		this.fpsText.text = 'FPS: ${MathLib.pretty(this.loop.frame.smoothFps, 0)}';
	}
}

class Main extends hxd.App {
	public static function main(): Void {
		Res.initEmbed();
		new Main();
	}

	/**
	 * Core application loop coordinating managers and systems.
	 */
	private var loop: MainLoop;

	private var debug: Debug;

	public override function init(): Void {
		s2d.renderer.globals.set("screenH", 800);
		s2d.renderer.globals.set("time", 0.0);
		s2d.renderer.globals.set("warp", 0.0);
		s2d.renderer.globals.set("vignetteIntensity", 0.0);
		s2d.renderer.globals.set("vignetteOpacity", 0.00);

		Commands.init();

		var window = hxd.Window.getInstance();
		window.title = "Simulacrum";
		window.addResizeEvent(() -> {
			s2d.renderer.globals.set("screenH", window.height);
		});

		this.loop = MainLoop.create(this);
		this.loop.scenes.set(new TestScene());

		this.debug = new Debug(this.loop);
	}

	public override function update(dt: Float): Void {
		this.loop.update(dt);
		this.debug.update();
	}
}
