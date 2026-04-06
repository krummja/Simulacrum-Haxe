package shaders;

class CheckerShader extends hxsl.Shader {
    // @formatter:off
    private static var SRC = {
        @:import h3d.shader.Base2d;

        @global var screenW: Float;
        @global var screenH: Float;
        @param var size: Float;
        @param var primary: Vec3 = vec3(1.0, 1.0, 1.0);
        @param var secondary: Vec3 = vec3(0.7, 0.7, 0.7);

        function fragment() {
            var pos: Vec2 = floor(vec2(calculatedUV.x * screenW, calculatedUV.y * screenH) / size);
            var patternMask: Float = mod(pos.x + mod(pos.y, 2.0), 2.0);
            pixelColor.rgb = mix(primary, secondary, patternMask);
        }
    };

    public function new(size: Float = 30.0, primary: Int = 0x3D3D3D, secondary: Int = 0x888888) {
        super();
        this.size = size;
        this.primary = primary.toHxdColor().toVector();
        this.secondary = secondary.toHxdColor().toVector();
    }
    // @formatter:on
}
