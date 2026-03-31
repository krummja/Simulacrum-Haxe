package core;

import haxe.ui.core.ItemRenderer;
import haxe.ui.core.Screen;
import haxe.ui.*;
import haxe.ui.containers.*;
import haxe.ui.components.*;
import haxe.ui.data.*;

@:xml('
<box height="100%" width="100%">
	<style>
		.custom {
			color: #ffffff;
			border: 1px solid #ffffff;
			padding: 10px;
			font-size: 24px;
		}
	</style>
	<vbox>
		<hbox>
			<label id="textfield" styleName="custom" text="0" />
            <button id="deinc" styleName="red" text="-" />
            <button id="inc" text="+" />
		</hbox>
        <listview id="inventory" width="100%">
            <item-renderer id="inventoryList" layout="vertical" width="100%" style="border: 1px solid #ff0000;">
                <label id="itemName" style="font-size: 24px;" text="0" width="100%" />
            </item-renderer>
        </listview>
	</vbox>
</box>
')
class HUDComponent extends Box {
	public var hp: Int = 100;

	public function new() {
		super();
		textfield.text = 'HP: ${hp}';

		deinc.onClick = function(e) {
			textfield.text = 'HP: ${hp}';
			hp -= 1;
		}

		inc.onClick = function(e) {
			textfield.text = 'HP: ${hp}';
			hp += 1;
		}

		for (i in 0...10) {
			inventory.dataSource.add({itemName: 'Item ${i}'});
		}

		inventory.onClick = function(e) {
			inventory.dataSource.removeAt(inventory.selectedIndex);
		}
	}
}

class UIManager {
	public var loop(default, null): MainLoop;

	public var hud(default, null): HUDComponent;

	public function new(loop: MainLoop) {
		this.loop = loop;
		Toolkit.init({root: this.loop.layers.root});

		this.hud = new HUDComponent();
		this.loop.layers.render(HUD, this.hud);
	}
}
