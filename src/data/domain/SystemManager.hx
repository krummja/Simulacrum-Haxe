package data.domain;

import data.domain.systems.AnimationSystem;
import echoes.Echoes;
import data.domain.systems.MovementSystem;
import core.MainLoop;
import data.domain.systems.RenderSystem;

class SystemManager {
	public var loop(get, never): MainLoop;

	public var movement_system(default, null): MovementSystem;
	public var animation_system(default, null): AnimationSystem;
	public var render_system(default, null): RenderSystem;

	public function new() {
		movement_system = new MovementSystem();
		animation_system = new AnimationSystem();
		render_system = new RenderSystem();
	}

	public function activateAll() {
		movement_system.activate();
		animation_system.activate();
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
