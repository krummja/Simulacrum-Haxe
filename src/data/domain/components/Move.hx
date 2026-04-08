package data.domain.components;

import common.util.Easing.EasingType;
import common.struct.Coordinate;

class Move {
	public var start: Coordinate;
	public var goal: Coordinate;
	public var easing: EasingType;
	public var duration: Float;
	public var epsilon: Float;

	public var startTime: Float;

	public function new(goal: Coordinate, duration: Float = 1.0, easing: EasingType = EASE_LINEAR, epsilon: Float = 0.015) {
		this.goal = goal;
		this.duration = duration;
		this.easing = easing;
		this.epsilon = epsilon;
	}
}
