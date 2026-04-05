package data.domain.components;

class Position {
	public var x: Float = 0.0;
	public var y: Float = 0.0;

	public function new(x: Float, y: Float) {
		this.x = x;
		this.y = y;
	}

	public function setPosition(x: Float, y: Float) {
		this.x = x;
		this.y = y;
	}
}
