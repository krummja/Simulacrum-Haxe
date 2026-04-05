package data.domain.components;

class Moniker {
	public var baseName = "";

	public var displayName(get, never): String;

	public function new(baseName: String) {
		this.baseName = baseName;
	}

	private function get_displayName(): String {
		var name = baseName;
		return name;
	}
}
