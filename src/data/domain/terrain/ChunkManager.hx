package data.domain.terrain;

import core.MainLoop;
import core.MainLoop;
import common.struct.Grid;
import data.domain.terrain.Chunk;

class ChunkManager {
	public var chunkCountX(get, null): Int;
	public var chunkCountY(get, null): Int;
	public var chunkSize(get, null): Int;

	private var chunks: Grid<Chunk>;

	public function new() {}

	public function initialize() {
		this.chunks = new Grid<Chunk>(this.chunkCountX, this.chunkCountY);
	}

	public inline function getChunkId(cx: Float, cy: Float) {
		return this.chunks.id(cx.floor(), cy.floor());
	}

	public inline function getChunkById(chunkId: Int): Chunk {
		return this.chunks.getAt(chunkId);
	}

	private function get_chunkCountX(): Int {
		return MainLoop.getInstance().world.chunkCountX;
	}

	private function get_chunkCountY(): Int {
		return MainLoop.getInstance().world.chunkCountY;
	}

	private function get_chunkSize(): Int {
		return MainLoop.getInstance().world.chunkSize;
	}
}
