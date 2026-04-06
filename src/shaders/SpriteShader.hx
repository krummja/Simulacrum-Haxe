package shaders;

import core.MainLoop;

class SpriteShader extends hxsl.Shader {
	// @formatter:off
	private static var SRC = {
		var pixelColor: Vec4;

		@param var primary: Vec3;
		@param var secondary: Vec3;
		@param var outline: Vec3;
		@param var background: Vec3;
		@param var clearBackground: Int;
		@param var clearColor: Vec3;

		function fragment() {
			var color = pixelColor.rgb;
			var isBackground = pixelColor.a == 0;

			var isPrimary = !isBackground && pixelColor.r == 1 && pixelColor.g == 1 && pixelColor.b == 1;
			var isSecondary = !isBackground && pixelColor.r == 0 && pixelColor.g == 0 && pixelColor.b == 0;
			var isOutline = !isBackground && pixelColor.r == 1 && pixelColor.g == 0 && pixelColor.a == 0;

			var c = color;
			if (isPrimary) {
				color = primary;
			}

			else if (isSecondary) {
				color = secondary;
			}

			else if (isOutline) {
				color = outline;
			}

			else if (isBackground) {
				if (clearBackground == 1) {
					color = background;
					pixelColor.a = 1;
				}
			}

			if (color.r == 1.0 && color.g == 0.0 && color.b == 1.0) {
				color = clearColor;
			}

			pixelColor.rgb = color;
		}
	}

	public function new(primary: Int = 0x000000, secondary: Int = 0xffffff) {
		super();
		this.primary = primary.toHxdColor().toVector();
		this.secondary = secondary.toHxdColor().toVector();
		this.outline = MainLoop.getInstance().CLEAR_COLOR.toHxdColor().toVector();
		this.background = MainLoop.getInstance().CLEAR_COLOR.toHxdColor().toVector();
		this.clearColor = MainLoop.getInstance().CLEAR_COLOR.toHxdColor().toVector();
		this.clearBackground = 0;
	}
	// @formatter:on
}
