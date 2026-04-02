import core.SettingsManager;
import hxd.Res;
import core.MainLoop;
import data.Commands;
import data.TileResources;
import data.TextResources;
import data.scenes.TestScene;

class Main extends hxd.App {
	public static function main(): Void {
		Res.initLocal();
		new Main();
	}

	/**
	 * Core application loop coordinating managers and systems.
	 */
	private var loop: MainLoop;

	public override function init(): Void {
		var settingsManager = new SettingsManager("settings_test");
		trace(settingsManager.settings);

		s2d.renderer.globals.set("time", 0.0);
		s2d.renderer.globals.set("warp", 0.1);
		s2d.renderer.globals.set("vignetteIntensity", 0.1);
		s2d.renderer.globals.set("vignetteOpacity", 0.01);

		TextResources.init();
		TileResources.init();
		Commands.init();

		var window = hxd.Window.getInstance();

		s2d.renderer.globals.set("screenH", window.height);

		window.title = settingsManager.settings.application.title;
		window.addResizeEvent(() -> {
			s2d.renderer.globals.set("screenH", window.height);
		});

		this.loop = MainLoop.create(this);
		this.loop.scenes.set(new TestScene());
	}

	public override function update(dt: Float): Void {
		s2d.renderer.globals.set("time", this.loop.frame.elapsed);
		this.loop.update(dt);
	}
}
