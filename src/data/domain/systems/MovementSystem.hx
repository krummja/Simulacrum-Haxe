package data.domain.systems;

import common.util.Easing;
import common.util.Easing.EasingType;
import echoes.System;
import echoes.Entity;
import echoes.Echoes;
import core.MainLoop;
import common.struct.Coordinate;
import data.domain.components.Position;
import data.domain.components.Move;

class MovementSystem extends System {
	@:update private function updatePosition(entity: Entity, position: Position, move: Move, time: Float): Void {}
}
