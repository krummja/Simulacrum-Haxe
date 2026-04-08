package data.domain.components;

import h2d.Tile;
import h2d.Anim;
import common.util.Timeout;
import common.struct.FloatPoint;
import shaders.SpriteShader2;
import core.RenderLayerManager.RenderLayerType;

class SpriteAnim extends Drawable {
	public var animationKey(default, set): AnimationKey;
	public var endTile(default, set): TileKey;
	public var speed(default, set): Float;
	public var loop(default, set): Bool;
	public var destroyOnComplete: Bool;

	public var ob(default, null): Anim;
	public var tiles(get, never): Array<Tile>;

	public var startTime: Float;

	public function new(
		key: AnimationKey,
		endTile: TileKey,
		speed: Float = 15,
		primary: ColorKey = C_WHITE,
		secondary: ColorKey = C_BLACK,
		layer: RenderLayerType = OBJECT,
		loop: Bool = true
	) {
		this.animationKey = key;
		this.endTile = endTile;
		this.speed = speed;
		this.loop = loop;
		this.destroyOnComplete = false;

		super(primary, secondary, layer);

		ob = new Anim(tiles, speed);
		ob.onAnimEnd = this.onAnimEnd;
		ob.addShader(this.shader);
		ob.loop = loop;
	}

	public function getPosition(): FloatPoint {
		return new FloatPoint(this.ob.x, this.ob.y);
	}

	public function setPosition(x: Float, y: Float): Void {
		this.ob.setPosition(x, y);
	}

	public function getAnimClone(): Anim {
		var bm = new Anim(tiles, speed);

		var sh = new SpriteShader2(primary, secondary);
		bm.addShader(sh);

		return bm;
	}

	private function onAnimEnd() {
		if (!loop) {
			ob.visible = false;
		}
	}

	private function getDrawable(): h2d.Drawable {
		return this.ob;
	}

	private function get_tiles(): Array<Tile> {
		return AnimationResources.get(animationKey);
	}

	private function set_animationKey(value: AnimationKey): AnimationKey {
		this.animationKey = value;

		if (ob != null) {
			var old = ob;
			ob = new Anim(tiles, speed, old.parent);
			ob.loop = loop;
			ob.x = old.x;
			ob.y = old.y;
			ob.addShader(shader);
			old.remove();
		}

		return value;
	}

	private function set_speed(value: Float): Float {
		this.speed = value;

		if (ob != null) {
			ob.speed = value;
		}

		return value;
	}

	private function set_loop(value: Bool): Bool {
		this.loop = value;

		if (ob != null) {
			ob.loop = value;
		}

		return value;
	}

	private function set_endTile(value: TileKey): TileKey {
		this.endTile = value;
		return value;
	}
}
