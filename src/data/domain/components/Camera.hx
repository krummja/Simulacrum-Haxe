package data.domain.components;

import data.domain.systems.CameraSystem;
import common.util.Geom;
import common.util.M;
import common.struct.Coordinate;
import core.MainLoop;

class Camera {
	public static var MIN_ZOOM: Float = 1.0;
	public static var MAX_ZOOM: Float = 10;

	public var rawFocus: Coordinate;
	public var targetOffsetX: Float = 0.0;
	public var targetOffsetY: Float = 0.0;
	public var deadZonePctX: Float = 0.04;
	public var deadZonePctY: Float = 0.10;
	public var clampToLevelBounds: Bool = false;
	public var frictionX: Float = 0.0;
	public var frictionY: Float = 0.0;

	public var target: Null<Int>;
	public var bumpZoomFactor: Float = 0.0;
	public var baseFriction: Float = 0.89;
	public var bumpFriction: Float = 0.85;
	public var dx: Float = 0.0;
	public var dy: Float = 0.0;
	public var dz: Float = 0.0;
	public var baseZoom: Float = 10.0;
	public var zoomSpeed: Float = 0.0014;
	public var zoomFriction: Float = 0.9;
	public var trackingSpeed: Float = 100.0;
	public var brakeDistNearBounds: Float = 0.1;

	public var clampedFocus(default, set): Coordinate;
	public var bumpOffsetX(default, set): Float = 0.0;
	public var bumpOffsetY(default, set): Float = 0.0;

	public var pxWidth(get, never): Int;
	public var pxHeight(get, never): Int;
	public var cWidth(get, never): Int;
	public var cHeight(get, never): Int;
	public var zoom(get, never): Float;
	public var targetZoom(default, set): Float = 1.0;
	public var scroller(get, null): h2d.Object;
	public var loop(get, never): MainLoop;

	public var pxLeft(get, never): Int;
	public var pxRight(get, never): Int;
	public var pxTop(get, never): Int;
	public var pxBottom(get, never): Int;
	public var centerX(get, never): Int;
	public var centerY(get, never): Int;
	public var cLeft(get, never): Int;
	public var cRight(get, never): Int;
	public var cTop(get, never): Int;
	public var cBottom(get, never): Int;

	public function new() {
		rawFocus = new Coordinate(0, 0, WORLD);
		clampedFocus = new Coordinate(0, 0, WORLD);
		dx = dy = 0;
	}

	public inline function zoomTo(value: Float) {
		targetZoom = value;
	}

	public function forceZoom(value: Float) {
		baseZoom = targetZoom = M.fclamp(value, MIN_ZOOM, MAX_ZOOM);
		dz = 0;
	}

	public inline function bumpZoom(z: Float) {
		bumpZoomFactor = z;
	}

	public function isOnScreen(wx: Float, wy: Float, padding: Float = 0.0): Bool {
		return wx >= pxLeft - padding && wy <= pxRight + padding && wy >= pxTop - padding && wy <= pxBottom + padding;
	}

	public inline function isOnScreenRect(x: Float, y: Float, width: Float, height: Float, padding: Float = 0.0): Bool {
		return Geom.rectangleOverlaps(pxLeft - padding, pxTop - padding, pxWidth + padding * 2, pxHeight + padding * 2, x, y, width, height);
	}

	public inline function isOnScreenGrid(cx: Int, cy: Int, padding: Int = 32): Bool {
		var inWidth = cx * loop.UNIT_X >= pxLeft - padding && (cx + 1) * loop.UNIT_Y <= pxRight + padding;
		var inHeight = cy * loop.UNIT_Y >= pxTop - padding && (cy + 1) * loop.UNIT_Y <= pxBottom + padding;
		return inWidth && inHeight;
	}

	public inline function setTrackingSpeed(speed: Float) {
		trackingSpeed = M.fclamp(speed, 0.01, 10);
	}

	public inline function stopTracking() {
		target = null;
	}

	public function centerOnTarget(centerX: Float, centerY: Float) {
		if (target != null) {
			rawFocus = new Coordinate(
				centerX + targetOffsetX,
				centerY + targetOffsetY,
				WORLD,
			);
		}
	}

	public inline function bumpAng(a: Float, dist: Float) {
		bumpOffsetX += Math.cos(a) * dist;
		bumpOffsetY += Math.sin(a) * dist;
	}

	public inline function bump(x: Float, y: Float) {
		bumpOffsetX += x;
		bumpOffsetY += y;
	}

	private inline function set_clampedFocus(value: Coordinate): Coordinate {
		return clampedFocus = value;
	}

	private inline function set_bumpOffsetX(value: Float): Float {
		return bumpOffsetX = value;
	}

	private inline function set_bumpOffsetY(value: Float): Float {
		return bumpOffsetY = value;
	}

	private function get_pxWidth(): Int {
		var worldW = this.loop.world.worldWidth;
		var scale = this.loop.SCALE;
		return (worldW / scale / zoom).ceil();
	}

	private function get_pxHeight(): Int {
		var worldH = this.loop.world.worldHeight;
		var scale = this.loop.SCALE;
		return (worldH / scale / zoom).ceil();
	}

	private inline function get_cWidth(): Int {
		return (pxWidth / this.loop.UNIT_X).ceil();
	}

	private inline function get_cHeight(): Int {
		return (pxWidth / this.loop.UNIT_Y).ceil();
	}

	private inline function get_zoom(): Float {
		return baseZoom + bumpZoomFactor;
	}

	private inline function get_scroller(): h2d.Object {
		return MainLoop.getInstance().layers.scroller;
	}

	private inline function set_targetZoom(value: Float): Float {
		return targetZoom = M.fclamp(value, MIN_ZOOM, MAX_ZOOM);
	}

	private inline function get_pxLeft(): Int {
		return Std.int(clampedFocus.toWorld().x - pxWidth * 0.5);
	}

	private inline function get_pxRight(): Int {
		return Std.int(pxLeft + (pxWidth - 1));
	}

	private inline function get_pxTop(): Int {
		return Std.int(clampedFocus.toWorld().y - pxHeight * 0.5);
	}

	private inline function get_pxBottom(): Int {
		return pxTop + pxHeight - 1;
	}

	private inline function get_centerX(): Int {
		return Std.int((pxLeft + pxRight) * 0.5);
	}

	private inline function get_centerY(): Int {
		return Std.int((pxTop + pxBottom) * 0.5);
	}

	private inline function get_cLeft(): Int {
		return Std.int(pxLeft / loop.UNIT_X);
	}

	private inline function get_cRight(): Int {
		return (pxRight / loop.UNIT_X).ceil();
	}

	private inline function get_cTop(): Int {
		return Std.int(pxTop / loop.UNIT_Y);
	}

	private inline function get_cBottom(): Int {
		return (pxBottom / loop.UNIT_Y).ceil();
	}

	private inline function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}
}
