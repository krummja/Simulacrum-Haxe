package macros;

class ResourceMacros {
	public static function init() {
		#if macro
		hxd.res.Config.extensions.set("json", "common.res.JsonResource");
		#end
	}
}
