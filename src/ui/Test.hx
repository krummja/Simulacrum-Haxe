package ui;

import haxe.ui.containers.*;

@:xml('
<vbox>
    <style>
        .default {
            color: #ffffff;
        }
    </style>
    <label styleName="default" id="propName" />
    <label styleName="default" id="xVal" />
    <label styleName="default" id="yVal" />
</vbox>
')
class Test extends VBox {
	@:bind(propName.text)
	var _label: String;

	@:bind(xVal.text)
	var _x: String;

	@:bind(yVal.text)
	var _y: String;

	public function new(label: String, x: String, y: String) {
		super();
		this._label = label;
		this._x = x;
		this._y = y;
	}
}
