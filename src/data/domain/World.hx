package data.domain;

import echoes.Entity;
import core.Projection;
import core.MainLoop;
import common.struct.Coordinate;
import common.struct.IntPoint;
import data.domain.PlayerManager;
import data.domain.terrain.ChunkManager;
import data.domain.terrain.ZoneManager;
import data.domain.systems.*;
import data.domain.components.*;
import data.domain.prefabs.*;

class World {
	public var loop(get, null): MainLoop;
	public var player(default, null): PlayerManager;
	public var chunks(default, null): ChunkManager;
	public var zones(default, null): ZoneManager;

	public var zoneCountX(default, null): Int = 64;
	public var zoneCountY(default, null): Int = 48;
	public var zoneSize(default, null): Int = 64;

	public var chunksPerZone(default, never): Int = 4;
	public var chunkSize(get, never): Int;
	public var chunkCountX(get, never): Int;
	public var chunkCountY(get, never): Int;

	public var worldWidth(get, null): Int;
	public var worldHeight(get, null): Int;

	public var systems(default, null): SystemManager;

	public var started(get, null): Bool = false;

	public function new() {
		this.systems = new SystemManager();
		this.player = new PlayerManager(this);
		this.chunks = new ChunkManager();
		this.zones = new ZoneManager();
	}

	public function initialize(): Void {
		this.systems.addSystem(ON_UPDATE, new MovementSystem());
		this.systems.addSystem(ON_UPDATE, new RenderSystem());
		this.systems.activateAll();
	}

	public function start(): Void {
		for (x in 0...40) {
			for (y in 0...40) {
				var pos = new Coordinate(x, y, WORLD);
				pos = Projection.worldToPixel(pos.x, pos.y);
				var floor = new Floor(new Position(pos.x, pos.y));
				floor.sprite.drawable.setPosition(pos.x, pos.y);
			}
		}

		var pos = new Coordinate(2, 2, WORLD);
		this.player.create(pos);

		started = true;
	}

	public function update(): Void {
		this.systems.update();
	}

	public overload extern inline function getEntitiesAt(pos: IntPoint): Array<Entity> {
		// var w = pos.asWorld();
		// var idx = pos.asWorld().toChunkId();
		// var chunk = this.chunks.getChunkById(idx);

		// if (chunk.isNull()) return new Array<Entity>();

		// var local = w.toChunkLocal();
		// var ids = chunk.getEntityIdsAt(local.x, local.y);
		// return ids.map((id: String) -> this.loop.ecs.registry.getEntity(id));
		return [];
	}

	private function get_loop(): MainLoop {
		return MainLoop.getInstance();
	}

	private function get_worldWidth(): Int {
		return this.chunkCountX * this.chunkSize;
	}

	private function get_worldHeight(): Int {
		return this.chunkCountY * this.chunkSize;
	}

	private function get_chunkCountX(): Int {
		return this.zoneCountX * this.chunksPerZone;
	}

	private function get_chunkCountY(): Int {
		return this.zoneCountY * this.chunksPerZone;
	}

	private function get_chunkSize(): Int {
		return (this.zoneSize / this.chunksPerZone).ceil();
	}

	private function get_started(): Bool {
		return started;
	}
}
