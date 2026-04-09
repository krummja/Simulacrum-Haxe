package data.domain.components;

import common.struct.Coordinate;
import core.MainLoop;

class Camera {
	public var width: Float;
	public var height: Float;
	public var zoom: Float;
	public var focus(get, null): Coordinate;

	public var targetId: Int;
	public var scroller(get, null): h2d.Object;

	private function get_focus(): Coordinate {
		return new Coordinate(width / 2, height / 2, SCREEN);
	}

	private function get_scroller(): h2d.Object {
		return MainLoop.getInstance().layers.scroller;
	}
}
