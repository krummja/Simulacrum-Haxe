import hxd.Res;
import core.SettingsManager;
import core.MainLoop;
import data.Commands;
import data.ColorPaletteResources;
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
		SettingsManager.init("settings_test");

		s2d.renderer.globals.set("time", 0.0);
		s2d.renderer.globals.set("warp", SettingsManager.settings.display.warpAmount);
		s2d.renderer.globals.set("vignetteIntensity", 0.1);
		s2d.renderer.globals.set("vignetteOpacity", 0.01);

		TextResources.init();
		ColorPaletteResources.init();
		TileResources.init();
		Commands.init();

		var window = hxd.Window.getInstance();

		s2d.renderer.globals.set("screenH", window.height);

		window.title = SettingsManager.settings.application.title;
		window.addResizeEvent(() -> {
			s2d.renderer.globals.set("screenH", window.height);
		});

		var width = SettingsManager.settings.display.resolutionWidth;
		var height = SettingsManager.settings.display.resolutionHeight;
		window.resize(width, height);

		this.loop = MainLoop.create(this);
		this.loop.scenes.set(new TestScene());
	}

	public override function update(dt: Float): Void {
		s2d.renderer.globals.set("time", this.loop.frame.elapsed);
		s2d.renderer.globals.set("warp", SettingsManager.settings.display.warpAmount);
		this.loop.update(dt);
	}
}
