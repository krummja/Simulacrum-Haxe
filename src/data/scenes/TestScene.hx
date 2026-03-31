package data.scenes;

import echoes.View;
import h3d.Vector;
import data.components.Position;
import data.components.Sprite;
import echoes.Entity;
import data.systems.RenderSystem;
import core.Frame;
import core.KeyCode;
import core.Scene;

class TestScene extends Scene {
	private var title: h2d.Text;

	private var renderSystem: RenderSystem;

	private var direction: Vector = new Vector(0, 0);

	private var positionView: View<Position>;

	public function new() {}

	private override function onEnter(): Void {
		title = new h2d.Text(hxd.Res.fnt.bizcat.toFont());
		title.setScale(3);
		title.text = "Simulacrum";
		title.color = new h3d.Vector4(1, 1, 0.9);

		loop.render(HUD, title);

		renderSystem = new RenderSystem(this);
		renderSystem.activate();

		var testEntity: Entity = new Entity();
		testEntity.add(new Sprite(TK_STONES_1));
		testEntity.add(new Position(10.0, 100.0));

		positionView = renderSystem.getLinkedView(Position);
	}

	private override function onKeyDown(key: KeyCode): Void {
		switch (key) {
			case KEY_W:
				direction.y = -1;
			case KEY_A:
				direction.x = -1;
			case KEY_S:
				direction.y = 1;
			case KEY_D:
				direction.x = 1;
			case _:
		}
	}

	private override function onKeyUp(key: KeyCode): Void {
		switch (key) {
			case KEY_W:
				direction.y = 0;
			case KEY_S:
				direction.y = 0;
			case KEY_A:
				direction.x = 0;
			case KEY_D:
				direction.x = 0;
			case _:
		}
	}

	private override function update(frame: Frame): Void {
		title.textAlign = Center;
		var width = loop.window.width;
		var height = loop.window.height;

		title.x = width / 2;
		title.y = height / 2;

		positionView.iter((entity, position) -> {
			position.x += direction.x * 200 * frame.dt;
			position.y += direction.y * 200 * frame.dt;
		});
	}

	private override function onDestroy(): Void {
		title.remove();
	}
}
