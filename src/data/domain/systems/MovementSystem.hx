package data.domain.systems;

import core.MainLoop;
import data.domain.components.*;
import echoes.System;

class MovementSystem extends System {
	public var loop(get, never): MainLoop;

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
