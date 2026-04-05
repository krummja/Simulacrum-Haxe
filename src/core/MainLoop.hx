package core;

import data.domain.World;
import data.ColorKey;
import data.ColorPaletteKey;
import data.core.ColorPaletteResources;
import data.TextResources;
import h2d.Console;
import core.RenderLayerManager.RenderLayerType;
import echoes.Echoes;

class MainLoop {
	public var UNIT_X: Int = 16;
	public var UNIT_Y: Int = 16;
	public var CLEAR_COLOR: ColorKey = C_CLEAR;
	public var PALETTE_KEY: ColorPaletteKey = PALETTE_ANATHEMA;

	private static var instance: MainLoop;

	public static function getInstance(): MainLoop {
		return instance;
	}

	/**
	 * If no instance already exists, create a new `MainLoop`, initializing all attached
	 * managers and systems. Otherwise, return the existing `MainLoop` singleton.
	 */
	public static function create(app: hxd.App): MainLoop {
		if (instance != null)
			return instance;
		return new MainLoop(app);
	}

	/**
	 * Heaps App instance passed during construction.
	 */
	public var app(default, null): hxd.App;

	/**
	 * Heaps Window singleton instance, accessed via `hxd.Window.getInstance()`.
	 */
	public var window(get, never): hxd.Window;

	public var palette(get, null): ColorPalette;

	public var frame(default, null): core.Frame;

	public var camera(default, null): Camera;

	public var scenes(default, null): SceneManager;

	public var input(default, null): InputManager;

	public var commands(default, null): CommandManager;

	public var layers(default, null): RenderLayerManager;

	public var console(default, null): Console;

	public var world(default, null): World;

	public var ui(default, null): UIManager;

	public function new(app: hxd.App) {
		instance = this;
		this.app = app;

		this.frame = new core.Frame();
		this.layers = new RenderLayerManager();
		this.input = new InputManager();
		this.commands = new CommandManager();
		this.camera = new Camera();
		this.world = new World();
		this.scenes = new SceneManager(this);
		this.ui = new UIManager(this);

		this.console = new Console(TextResources.BIZCAT);
		ConsoleConfig.config(this.console);

		this.app.s2d.scaleMode = Fixed(800, 600, 1, Left, Top);
		this.app.s2d.addChild(this.layers.root);

		Echoes.init();
	}

	public inline function update(dt: Float): Void {
		app.s2d.renderer.globals.set("time", frame.elapsed);
		this.frame.update();
		this.scenes.current.update(this.frame);
		this.ui.update(this.frame);
	}

	public inline function render(layer: RenderLayerType, ob: h2d.Object): Void {
		return this.layers.render(layer, ob);
	}

	private function get_window(): hxd.Window {
		return hxd.Window.getInstance();
	}

	private function get_palette(): ColorPalette {
		return ColorPaletteResources.Get(PALETTE_KEY);
	}
}
