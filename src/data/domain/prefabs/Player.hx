package data.domain.prefabs;

import echoes.Entity;
import data.domain.components.Sprite;
import data.domain.components.SpriteAnim;
import data.domain.components.IsPlayer;
import data.domain.components.IsMovable;
import data.domain.components.Position;
import data.domain.components.Velocity;
import data.domain.components.Moniker;

@:build(echoes.Entity.build())
@:arguments(Position)
abstract Player(Entity) {
	public var position: Position;
	public var velocity: Velocity = new Velocity(0.0, 0.0);
	public var sprite: Sprite = new Sprite(PLAYER_S_STAND, C_RED_5, C_YELLOW_0, ACTOR);
	// public var sprite: SpriteAnim = new SpriteAnim(PLAYER_MOVE_DOWN, 6, C_RED_5, C_YELLOW_0, ACTOR);
	public var isPlayer: IsPlayer = new IsPlayer();
	public var isMovable: IsMovable = new IsMovable();
	public var moniker: Moniker = new Moniker("Player");
}
