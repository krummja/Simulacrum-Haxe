package core;

import common.util.FS;
import sys.FileSystem;

class FileManager {
	private var saveName: String;
	private var saveDirectory: String = "saves";

	public function new() {}

	public function setSaveName(name: String) {
		saveName = name;
		FileSystem.createDirectory(filePath(["test"]));
	}

	public function deleteSave(name: String) {
		FS.deletePath('$saveDirectory/$name', true);
	}

	private function filePath(parts: Array<String>): String {
		var all = [saveDirectory, saveName].concat(parts);
		return all.join("/");
	}
}
