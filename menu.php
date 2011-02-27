<?php
require_once("util/startup.php");
require_once("util/entities.php");
require_once("util/dao.php");

require_once("util/js_converter.php");
require_once("util/logging.php");

try {
	$builder = new MenuDAO($db);
	$menu = $builder->build("941a47b2-4183-11e0-8705-001c238ae411");
} catch (Exception $e) {
	Logging::error("Building Menu", $e->getMessage());
}
//$menu->printOut();

?>
Ext.ns('Tantalum');

function onMenuClick(item) {
	var url = 'page.php?id='+item.viewID;
	if (item.text == "Test") {
		url = 'temp/test.js';
	}
	Ext.Ajax.request( {
		url : url,
		success : function(xhr) {
			var newComponent = eval(xhr.responseText);
			var contentPanel = Ext.ComponentMgr.get('contentPanel');
			contentPanel.add(newComponent);
			contentPanel.setActiveTab(newComponent);
		},
		failure : function() {
			Ext.Msg.alert("Page Error", "Server communication failure");
		}
	});
}

Tantalum.Menu = Ext.extend(Ext.Panel, {
	region : 'north',
	bbar : [ {
		xtype : 'tbtext',
		text : '<b><?php echo $menu->data["label"] ?></b>'
	}, {
		xtype : 'tbseparator'
	}, {
		xtype : 'button',
		text : 'Test',
		handler : onMenuClick,
		iconCls : 'icon-form-edit'
	}
<?php 
	foreach ($menu->subMenus as $submenu) {
		$menuJS = new JavaScriptObject();
		$menuJS->add("xtype", "button");
		$menuJS->add("text", $submenu->data["label"]);
		$menuJS->addRaw("handler", "onMenuClick");
		$menuJS->add("iconCls", "icon-form-edit");
		$menuJS->add("viewID", $submenu->data["viewID"]);
		echo "," . $menuJS->printOut();
	}
?>
	],
	initComponent : function() {
		Tantalum.Menu.superclass.initComponent.call(this);
	}
});

Ext.reg('tantalum-menu', Tantalum.Menu);
