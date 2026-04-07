package core;

import common.struct.IntPoint;

class Input2D {
	public var x(default, null): Int = 0;
	public var y(default, null): Int = 0;

	public var mixInputs(default, null): Bool;

	public function new(mixInputs: Bool) {
		this.mixInputs = mixInputs;
	}

	public function toIntPoint(): IntPoint {
		return new IntPoint(this.x, this.y);
	}

	public function setHorizontal(value: Int) {
		x = value;
		if (!mixInputs) {
			y = 0;
		}
	}

	public function setVertical(value: Int) {
		y = value;
		if (!mixInputs) {
			x = 0;
		}
	}

	public function clear() {
		x = 0;
		y = 0;
	}
}
