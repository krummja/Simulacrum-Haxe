package shaders;

import h3d.shader.ScreenShader;

class ScanlineShader extends ScreenShader {
	// @formatter:off
	static var SRC = {
		@param var texture: Sampler2D;
		@highp var idx: Float;
		@global var screenH: Float;
		@global var time: Float;
		@global var warp: Float;
		@global var vignetteIntensity: Float;
		@global var vignetteOpacity: Float;

		function warpCalc(uv: Vec2): Vec2 {
			var delta: Vec2 = uv - 0.5;
			var delta2: Float = dot(delta.xy, delta.xy);
			var delta4: Float = delta2 * delta2;
			var delta_offset: Float = delta4 * warp;
			return uv + delta * delta_offset;
		}

		function borderCalc(uv: Vec2): Float {
			var radius: Float = min(warp, 0.08);
			radius = max(min(min(abs(radius * 2.0), abs(1.0)), abs(1.0)), 1e-5);
			var abs_uv: Vec2 = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius;
			var dist: Float = length(max(vec2(0.0), abs_uv)) / radius;
			var square: Float = smoothstep(0.96, 1.0, dist);
			return clamp(1.0 - square, 0.0, 1.0);
		}

		function vignetteCalc(uv: Vec2): Float {
			uv *= 1.0 - uv.xy;
			var vign: Float = uv.x * uv.y * 15.0;
			return pow(vign, vignetteIntensity * vignetteOpacity);
		}

		function randomUV(uv: Vec2): Vec2 {
			uv = vec2(
				dot(uv, vec2(127.1, 311.7)),
				dot(uv, vec2(269.5, 183.3))
			);

			return -1.0 + 2.0 * fract(sin(uv) * 43758.5353123);
		}

		function noiseDistort(uv: Vec2): Float {
			var uv_index: Vec2 = floor(uv);
			var uv_fract: Vec2 = fract(uv);
			var blur: Vec2 = smoothstep(0.0, 1.0, uv_fract);

			return mix(
				mix(
					dot(randomUV(uv_index + vec2(0.0, 0.0)), uv_fract - vec2(0.0, 0.0)),
					dot(randomUV(uv_index + vec2(1.0, 0.0)), uv_fract - vec2(1.0, 0.0)),
					blur.x
				),
				mix(
					dot(randomUV(uv_index + vec2(0.0, 1.0)), uv_fract - vec2(0.0, 1.0)),
					dot(randomUV(uv_index + vec2(1.0, 1.0)), uv_fract - vec2(1.0, 1.0)),
					blur.x
				),
				blur.y
			) * 0.5 + 0.5;
		}

		function fragment() {
			var pi = 3.14159265;
			var blurSize = 0.15;
			var subtleLevel = 0.8;
			var scanlineSize = 3;
			var boost = 1.125;
			var invH = 1.0 / screenH;

			var border = vec4(0.0, 0.0, 0.0, 0.0);
			var blur = vec4(0.0, 0.0, 0.0, 0.0);
			var vignette = vec4(0.0, 0.0, 0.0, 0.0);
			var rollUV = vec2(0.0);
			var uv = calculatedUV;
			uv = warpCalc(uv);

			blur += texture.get(uv + vec2(-blurSize, -blurSize) * invH);
			blur += texture.get(uv + vec2(-blurSize, blurSize) * invH);
			blur += texture.get(uv + vec2(blurSize, -blurSize) * invH);
			blur += texture.get(uv + vec2(blurSize, blurSize) * invH);

			blur += texture.get(uv + vec2(-blurSize, 0) * invH);
			blur += texture.get(uv + vec2(blurSize, 0) * invH);
			blur += texture.get(uv + vec2(-blurSize, -blurSize) * invH);
			blur += texture.get(uv + vec2(0, -blurSize) * invH);
			blur += texture.get(uv + vec2(0, blurSize) * invH);
			blur *= 0.125;

			// border += texture.get(uv);
			// border.rgb *= borderCalc(uv);

			// vignette += texture.get(uv);
			// vignette.rgb *= vignetteCalc(uv);

			var vPos = calculatedUV.y * screenH;
			// var r = fract(sin(dot(calculatedUV * time, vec2(12.9898, 78.233))) * 43758.5453);
			var lineIntensity = (subtleLevel) + abs(cos(pi / scanlineSize * vPos));

			var amt = clamp(lineIntensity, 0.0, 1.125);

			pixelColor = blur * amt * boost;
		}
		// @formatter:on
	};
}
