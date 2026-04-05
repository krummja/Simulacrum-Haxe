package data.domain;

import data.domain.systems.MovementSystem;
import core.MainLoop;
import data.domain.systems.RenderSystem;

class SystemManager {
	public var loop(get, never): MainLoop;

	public var render_system(default, null): RenderSystem;

	public var movement_system(default, null): MovementSystem;

	public function new() {
		render_system = new RenderSystem();
		movement_system = new MovementSystem();
	}

	public function activateAll() {
		render_system.activate();
		movement_system.activate();
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
