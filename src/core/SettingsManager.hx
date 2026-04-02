package core;

import common.util.FS;
import haxe.Json;
import sys.io.File;
import sys.FileSystem;

typedef ApplicationSettings = {
	var title: String;
}

typedef DisplaySettings = {
	resolutionWidth: Int,
	resolutionHeight: Int,
	fullScreen: Bool,
}

typedef GraphicsSettings = {
	vsyncEnabled: Bool,
}

typedef AudioSettings = {
	masterVolume: Int,
	effectsVolume: Int,
	musicVolume: Int,
	voiceVolume: Int,
	ambientVolume: Int,
}

typedef InputSettings = {}

typedef Settings = {
	application: ApplicationSettings,
	display: DisplaySettings,
	graphics: GraphicsSettings,
	audio: AudioSettings,
	input: InputSettings,
}

class SettingsManager {
	public var settings(default, null): Settings;

	private var settingsDirectory: String = "settings";

	public function new(fileName: String) {
		if (!FileSystem.exists(settingsDirectory)) {
			FileSystem.createDirectory(settingsDirectory);
		}

		if (!FileSystem.exists(FS.filePath([settingsDirectory, '${fileName}.json']))) {
			loadDefaults();
			writeSettings('${fileName}.json');
		}

		readSettings('${fileName}.json');
	}

	private function readSettings(name: String) {
		var fileData = File.getContent(FS.filePath([settingsDirectory, name]));
		var errors = new Array<json2object.Error>();
		settings = new json2object.JsonParser<Settings>(errors).fromJson(fileData, name);
	}

	private function writeSettings(name: String) {
		var settingsData = Json.stringify(settings, "\t");
		File.saveContent(FS.filePath([settingsDirectory, name]), settingsData);
	}

	private function loadDefaults() {
		settings = {
			application: {
				title: "",
			},
			display: {
				resolutionWidth: 1200,
				resolutionHeight: 800,
				fullScreen: false,
			},
			graphics: {
				vsyncEnabled: true,
			},
			audio: {
				masterVolume: 100,
				ambientVolume: 100,
				voiceVolume: 100,
				musicVolume: 100,
				effectsVolume: 100,
			},
			input: {},
		};
	}

	// private var settingsName: String;
	// private var settingsDirectory: String = "settings";
	// public function new(name: String) {
	// 	if (!FileSystem.exists(filePath(['${name}.json']))) {
	// 		// Directory does not exist - create and add default config
	// 		setSettingsName(name);
	// 		loadDefaults();
	// 		writeSettings(name);
	// 	} else if (!FileSystem.exists(filePath(['${name}.json']))) {
	// 		// Directory exists, but config does not exist - create default
	// 		loadDefaults();
	// 		writeSettings(name);
	// 	} else {
	// 		// Both directory and config exist - load from file
	// 		readSettings(name);
	// 	}
	// }
	// public function setSettingsName(name: String) {
	// 	settingsName = name;
	// 	FileSystem.createDirectory(settingsDirectory);
	// }
	// public function readSettings(name: String) {
	// 	var fileData = File.getContent(filePath(['${name}.json']));
	// 	var errors = new Array<json2object.Error>();
	// 	settings = new json2object.JsonParser<Settings>(errors).fromJson(fileData, '${name}.json');
	// }
	// public function writeSettings(name: String) {
	// 	var settingsData = Json.stringify(settings, "\t");
	// 	File.saveContent(filePath(['${name}.json']), settingsData);
	// }
	// public function deleteSettings(name: String) {
	// 	FS.deletePath(filePath(['${name}.json']));
	// }
	// private function filePath(parts: Array<String>): String {
	// 	var all = [settingsDirectory].concat(parts);
	// 	return all.join("/");
	// }
}
