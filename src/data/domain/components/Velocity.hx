package data.domain.components;

class Velocity {
	public var x: Float = 0.0;
	public var y: Float = 0.0;

	public function new(x: Float, y: Float) {
		this.x = x;
		this.y = y;
	}

	public function update(x: Float, y: Float) {
		this.x = x;
		this.y = y;
	}
}
