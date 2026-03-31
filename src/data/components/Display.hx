package data.components;

import h2d.Drawable;

abstract class Display {
	public var drawable(get, never): Drawable;

	abstract private function getDrawable(): h2d.Drawable;

	private inline function get_drawable(): h2d.Drawable {
		return getDrawable();
	}
}
