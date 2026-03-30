import core.MainLoop;

class Main extends hxd.App {
	private var loop: core.MainLoop;

	public static function main(): Void {
		new Main();
	}

	public override function init(): Void {
		hxd.Window.getInstance().title = "Simulacrum";

		this.loop = MainLoop.Create(this);
	}

	public override function update(dt: Float): Void {
		this.loop.update(dt);
	}
}
