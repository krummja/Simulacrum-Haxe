package data.domain.prefabs;

import echoes.Entity;
import common.struct.Coordinate;

abstract class Prefab {
	public function new() {}

	public abstract function create(options: Dynamic, pos: Coordinate): Entity;
}
