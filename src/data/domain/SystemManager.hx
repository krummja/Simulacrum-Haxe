package data.domain;

import echoes.Echoes;
import data.domain.systems.MovementSystem;
import core.MainLoop;
import data.domain.systems.RenderSystem;

class SystemManager {
	public var loop(get, never): MainLoop;

	public var render_system(default, null): RenderSystem;

	public var movement_system(default, null): MovementSystem;

	public function new() {
		movement_system = new MovementSystem();
		render_system = new RenderSystem();
	}

	public function activateAll() {
		// movement_system.activate();
		render_system.activate();
	}

	public function update() {
		Echoes.update();
		// trace(Echoes.getStatistics());
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
