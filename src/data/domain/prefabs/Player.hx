package data.domain.prefabs;

import echoes.Entity;
import data.domain.components.Sprite;
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
	public var sprite: Sprite = new Sprite(PLAYER_1, C_YELLOW_0, C_BLUE_4, ACTOR);
	public var isPlayer: IsPlayer = new IsPlayer();
	public var isMovable: IsMovable = new IsMovable();
	public var moniker: Moniker = new Moniker("Player");
}
