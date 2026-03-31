package data.systems;

import data.components.Position;
import data.components.Sprite;
import core.Scene;
import echoes.System;
import echoes.Entity;

class RenderSystem extends System {
	public final scene: Scene;

	public function new(scene: Scene) {
		super();
		this.scene = scene;
	}

	@:add private function onDisplayAdded(display: Sprite): Void {
		this.scene.loop.render(OBJECT, display.drawable);
	}

	@:remove private function onDisplayRemoved(display: Sprite): Void {
		display.drawable.remove();
	}

	@:update private function updatePosition(display: Sprite, position: Position): Void {
		display.drawable.setPosition(position.x, position.y);
	}
}
