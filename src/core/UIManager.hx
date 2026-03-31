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
	public function new() {
		super();
		textfield.text = 'HP: ${UIManager.hp}';

		deinc.onClick = function(e) {
			UIManager.hp -= 1;
			textfield.text = 'HP: ${UIManager.hp}';
		}

		inc.onClick = function(e) {
			UIManager.hp += 1;
			textfield.text = 'HP: ${UIManager.hp}';
		}

		for (i in 0...10) {
			inventory.dataSource.add({itemName: 'Item ${i}'});
		}

		inventory.onClick = function(e) {
			inventory.dataSource.removeAt(inventory.selectedIndex);
		}
	}
}

@:xml('
<vbox width="100%" height="100%" style="padding: 10px">
	<hbox id="wrapper" width="100%" height="100%">
		<box id="rootInner" width="100%" height="100%" style="padding: 5px; background-color: #b41c2b">
		</box>
	</hbox>
</vbox>
')
class UIRoot extends Box {
	public function new(width: Float, height: Float) {
		super();
		wrapper.width = width;
		wrapper.height = height;
	}
}

class UIManager {
	public var loop(default, null): MainLoop;

	public static var ui_root: UIRoot;
	public static var hp: Int = 100;

	public function new(loop: MainLoop) {
		this.loop = loop;
		Toolkit.init({root: this.loop.layers.root});

		UIManager.ui_root = new UIRoot(this.loop.window.width, this.loop.window.height);
		this.loop.layers.render(HUD, UIManager.ui_root);
	}
}
