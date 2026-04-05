package core;

import h2d.Bitmap;
import h2d.filter.Shader;
import h2d.filter.Group;
import h2d.filter.Blur;
import core.RenderLayer;
import shaders.ScanlineShader;

enum RenderLayerType {
	BACKGROUND;
	GROUND;
	OBJECT;
	ACTOR;
	EFFECT;
	OVERLAY;
	HUD;
	POPUP;
}

class RenderLayerManager {
	public var root(default, null): h2d.Layers;
	public var scroller(default, null): h2d.Layers;
	public var screen(default, null): h2d.Layers;
	public var underlay: h2d.Bitmap;

	private var scrollerCount: Int = 0;
	private var screenCount: Int = 0;
	private var layers: Map<RenderLayerType, RenderLayer>;

	public function new() {
		this.root = new h2d.Layers();

		// this.underlay = new h2d.Bitmap(h2d.Tile.fromColor(0x505050));
		// this.underlay.width = 10000;
		// this.underlay.height = 10000;

		this.scroller = new h2d.Layers();
		this.screen = new h2d.Layers();

		this.layers = new Map();

		// World Layers
		this.createLayer(BACKGROUND, WORLD);
		this.createLayer(GROUND, WORLD);
		this.createLayer(OBJECT, WORLD);
		this.createLayer(ACTOR, WORLD);
		this.createLayer(EFFECT, WORLD);
		this.createLayer(OVERLAY, WORLD);

		// Screen Layers
		this.createLayer(HUD, SCREEN);
		this.createLayer(POPUP, SCREEN);

		// this.root.addChildAt(this.underlay, 0);
		this.root.addChildAt(this.scroller, 1);
		this.root.addChildAt(this.screen, 2);

		var scanlineShader = new Shader(new ScanlineShader());
		var blurShader = new Blur();

		var postprocess = new Group([scanlineShader, blurShader]);

		scanlineShader.enable = true;
		blurShader.enable = false;
		postprocess.enable = SettingsManager.settings.display.scanlines;

		this.root.filter = postprocess;
		this.root.filter.enable = SettingsManager.settings.display.scanlines;
	}

	public function createLayer(type: RenderLayerType, space: RenderLayerSpace): RenderLayer {
		var layer = new RenderLayer(space);

		switch layer.space {
			case WORLD:
				this.scroller.add(layer.ob, this.scrollerCount++);
			case SCREEN:
				this.screen.add(layer.ob, screenCount++);
		}

		this.layers.set(type, layer);
		return layer;
	}

	public function render(layerType: RenderLayerType, ob: h2d.Object): Void {
		this.layers.get(layerType).ob.addChild(ob);
	}

	public function clear(renderLayer: RenderLayerType): Void {
		this.layers.get(renderLayer).ob.removeChildren();
	}

	public function clearAll(): Void {
		this.layers.each((layer) -> layer.ob.removeChildren());
	}
}
