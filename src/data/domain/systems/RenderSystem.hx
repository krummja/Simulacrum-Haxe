package data.domain.systems;

import core.Projection;
import core.MainLoop;
import data.domain.components.Position;
import data.domain.components.Sprite;
import echoes.System;
import echoes.Entity;

class RenderSystem extends System {
	public var loop(get, never): MainLoop;

	@:add private function onDisplayAdded(display: Sprite): Void {
		this.loop.render(display.layer, display.drawable);
	}

	@:remove private function onDisplayRemoved(display: Sprite): Void {
		display.drawable.remove();
	}

	@:update private function updatePosition(display: Sprite, position: Position): Void {
		var coord = Projection.worldToPixel(position.x, position.y);
		display.drawable.setPosition(coord.x, coord.y);
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
