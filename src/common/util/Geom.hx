package common.util;

class Geom {
	public static function rectangleOverlaps(aX: Float, aY: Float, aWidth: Float, aHeight: Float, bX: Float, bY: Float, bWidth: Float, bHeight: Float): Bool {
		if (aY + aHeight <= bY || bY + bHeight <= aY) {
			return false;
		} else if (aX + aWidth <= bY || bX + bWidth <= aX) {
			return false;
		}
		return true;
	}
}
