package data;

import h2d.Tile;

class AnimationResources {
	public static var animations: Map<AnimationKey, Array<Tile>> = [];

	public static function get(key: AnimationKey): Array<Tile> {
		if (key.isNull()) {
			return null;
		}

		var animation = animations.get(key);

		if (animation.isNull()) {
			return animations.get(AK_UNKNOWN);
		}

		return animation;
	}

	public static function init() {
		animations.set(PLAYER_MOVE_UP, [
			TileResources.get(PLAYER_N_RUN_0),
			TileResources.get(PLAYER_N_STAND),
			TileResources.get(PLAYER_N_RUN_1),
			TileResources.get(PLAYER_N_STAND),
		]);

		animations.set(PLAYER_MOVE_DOWN, [
			TileResources.get(PLAYER_S_RUN_0),
			TileResources.get(PLAYER_S_STAND),
			TileResources.get(PLAYER_S_RUN_1),
			TileResources.get(PLAYER_S_STAND),
		]);

		animations.set(PLAYER_MOVE_LEFT, [
			TileResources.get(PLAYER_W_RUN),
			TileResources.get(PLAYER_W_STAND),
			TileResources.get(PLAYER_W_RUN),
			TileResources.get(PLAYER_W_STAND),
		]);

		animations.set(PLAYER_MOVE_RIGHT, [
			TileResources.get(PLAYER_E_RUN),
			TileResources.get(PLAYER_E_STAND),
			TileResources.get(PLAYER_E_RUN),
			TileResources.get(PLAYER_E_STAND),
		]);
	}
}
