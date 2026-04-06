package ui;

import haxe.ui.components.Label;
import haxe.ui.containers.*;

@:xml('
<vbox>
	<style>
		.text {
			color: #ffffff;
			width: 100%;
		}
	</style>

	<label styleName="text" id="propName" />
	<hbox width="100px">
		<label styleName="text" id="xLabel" text="x" horizontalAlign="left" />
		<label styleName="text" id="xValue" text="0" horizontalAlign="right" />
	</hbox>
	<hbox width="100px">
		<label styleName="text" id="yLabel" text="y" horizontalAlign="left" />
		<label styleName="text" id="yValue" text="0" horizontalAlign="right" />
	</hbox>
</vbox>
')
class XYMetric extends VBox {
	public function new(label: String, x: String, y: String) {
		super();
		propName.text = label;
		xValue.text = x;
		yValue.text = y;

		customStyle = {
			width: 100,
			horizontalAlign: "right",
			backgroundColor: 0x000000,
			backgroundOpacity: 0.3,
			paddingLeft: 4,
			paddingRight: 4,
			paddingTop: 4,
			paddingBottom: 4,
		};
	}

	public function update(x: Float, y: Float) {
		xValue.text = '${x.floor()}';
		yValue.text = '${y.floor()}';
	}
}
