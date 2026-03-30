package core;

class MainLoop {
	public static var instance: MainLoop;

	public var app(default, null): hxd.App;
	public var window(get, never): hxd.Window;

	public var frame(default, null): Frame;
	public var scenes(default, null): SceneManager;
	public var input(default, null): InputManager;
	public var commands(default, null): CommandManager;

	public static function Create(app: hxd.App): MainLoop {
		if (instance != null)
			return instance;
		return new MainLoop(app);
	}

	public function new(app: hxd.App) {
		instance = this;
		this.app = app;

		this.input = new InputManager();
	}

	public inline function update(dt: Float): Void {}

	private function get_window(): hxd.Window {
		return hxd.Window.getInstance();
	}
}
