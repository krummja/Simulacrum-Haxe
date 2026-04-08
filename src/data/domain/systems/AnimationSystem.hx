package data.domain.systems;

import echoes.System;
import echoes.Entity;
import data.domain.components.Sprite;
import data.domain.components.SpriteAnim;
import data.domain.components.Position;
import core.Projection;
import core.MainLoop;

class AnimationSystem extends System {
	public var loop(get, never): MainLoop;

	@:add private function onAnimAdded(anim: SpriteAnim): Void {
		this.loop.render(anim.layer, anim.drawable);
	}

	@:update private function updateAnim(anim: SpriteAnim, position: Position, ?sprite: Sprite): Void {
		if (sprite != null) {
			sprite.visible = false;
		}
		var coord = Projection.worldToPixel(position.x, position.y);
		anim.setPosition(coord.x, coord.y);
	}

	// @:update private function updateAnimEnd(entity: Entity, anim: SpriteAnim, ?sprite: Sprite): Void {
	// 	var timeoutId = '${entity.id}-${anim.animationKey}';
	// 	var animTimer = loop.timeout.get(timeoutId);
	// 	if (animTimer == null || animTimer.isComplete) {
	// 		if (sprite != null) {
	// 			entity.remove(sprite);
	// 			entity.add(new Sprite(anim.endTile, sprite.primary, sprite.secondary, sprite.layer));
	// 		}
	// 		entity.remove(anim);
	// 		return;
	// 	}
	// }

	@:remove private function onAnimRemoved(anim: SpriteAnim): Void {
		anim.drawable.remove();
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
