<?php
require_once("js_converter.php");
require_once("page_store.php");
require_once("page_grid.php");
require_once("page_form.php");

/**
 * @param View $view
 * @param String $type Add or Delete
 */
function buildButtons($view, $type) {
	$buttons = new JavaScriptArray();
	if ($view->model != null) {
		$button = new JavaScriptObject();
		$button->addRaw("handler", $type . $view->model->getName(). "Store");
		$button->add("text", $type . " " . $view->data["label"]);
		$buttons->add($button);
	}
	
	foreach ($view->childViews as $child) {
		$buttons->addAll(buildButtons($child, $type));
	}
	return $buttons;
}

function createView($view) {
	if ($view->data["viewType"] == "Grid") {
		createGrid($view);
	}
	if ($view->data["viewType"] == "Form") {
		createForm($view);
	}
	foreach ($view->childViews as $childView) {
		createView($childView);
	}
}

/**
 * @param View $view
 */
function printView($view) {
	$childCount = count($view->childViews);
	$viewType = $view->data["viewType"];
	$viewJS = new JavaScriptObject();
	$items = new JavaScriptArray();
	
	if ($viewType == "Form" || $viewType == "Grid") {
		$out = $view->getName() . "View";
		foreach ($view->childViews as $childView) {
			$out .= ", " . printView($childView);
		}
		return $out;
	} else {
		$viewJS->add("xtype", "tabpanel");
		$viewJS->add("flex", 10);
		if ($childCount > 0) {
			$viewJS->add("activeTab", 0);
		}
	}
	
	$viewJS->addRaw("items", $items);
	foreach ($view->childViews as $childView) {
		$items->addRaw(printView($childView));
	}
	return $viewJS->printOut();
}
?>
(function() {
	var saveQueue;
	var writer = new Ext.data.JsonWriter({});

	<?php
	createStore($view->getModel());
	createView($view);
	$searchFields = $view->getSearchableFields();
	$showSearch = count($searchFields) > 0;
	if ($showSearch) {
		?>
		var searchForm = new Ext.form.FormPanel({
			padding: 5,
			defaultType: 'textfield',
			<?php
			$itemArray = new JavaScriptArray();
			foreach ($searchFields as $field) {
				$fieldData = new JavaScriptObject();
				$fieldData->add("id", $field->getName());
				$fieldData->add("name", $field->getName());
				$fieldData->add("fieldLabel", $field->data["label"]);
				$itemArray->add($fieldData);
			}
			echo "items: " . $itemArray->printOut();
			?>
		});
		
		var searchWindow = new Ext.Window({
	        title: 'Search',
	        width: 500,
	        height:300,
	        minWidth: 300,
	        minHeight: 200,
	        layout: 'fit',
	        plain:true,
	        bodyStyle:'padding:5px;',
	        buttonAlign:'center',
	        items: searchForm,
	        buttons: [{
	            text: 'Search',
				handler: function(button, event) {
					var condition = "";
					<?php
					foreach ($searchFields as $field) { ?>
						var searchValue = searchForm.getComponent("<?php echo $field->getName() ?>").getValue();
						if (searchValue.length > 0) {
							if (condition != "") condition += " AND ";
							condition += "<?php echo $field->getName() ?> LIKE '%" + searchValue + "%'";
						}
						<?php
					}
					?>
					<?php echo $view->getModel()->getName() ?>Store.load({"params" : {"condition" : condition}});
				}
	        },{
				handler: function(button, event) {
					searchWindow.hide();
				},
	            text: 'Cancel'
	        }]
	    });
		<?php
	}
	?>
	var tb = new Ext.Toolbar({
		items: [{
	<?php if ($showSearch) { ?>
			iconCls : 'icon-magnifier',
			handler: function(button, event) {
				searchWindow.show();
			},
			text: 'Search'
		},{
	<?php } ?>
			iconCls : 'icon-refresh',
			handler: function(b, e) {
				<?php echo $view->getModel()->getName() ?>Store.reload();
			},
			text: 'Refresh'
		},{
			iconCls : 'icon-disk',
			itemId : 'save',
			handler: function(button, event) {
				save<?php echo $view->getModel()->getName() ?>Store();
			},
			text: 'Save'
		},{
			iconCls : 'icon-plus',
			itemId : 'add',
			menu : {
				items: <?php echo buildButtons($view, "Add")->printOut() ?>
            },
			text: 'Add'
		},{
			iconCls : 'icon-minus',
			itemId : 'delete',
			menu : {
				items: <?php echo buildButtons($view, "Delete")->printOut() ?>
            },
			// tooltip: {text:'This is a an example QuickTip for a toolbar item', title:'Tip Title'},
			text: 'Delete'
		},{
			xtype: 'tbfill'
		},{
			iconCls : 'icon-arrow-left',
			handler: function(button, event) {
				Position<?php echo $view->model->getName() ?>StoreChange(-1);
			},
			text: 'Previous'
		},{
			iconCls : 'icon-arrow-right',
			iconAlign: 'right',
			handler: function(button, event) {
				Position<?php echo $view->model->getName() ?>StoreChange(1);
			},
			text: 'Next'
		}]
	});
	
	var page = new Ext.Panel({
		currentStore : null,
		title : '<?php echo $view->data["label"] ?>',
		layout : 'vbox',
		layoutConfig : {
		    align : 'stretch',
		    flex : 1
		},
		filter : function(condition) {
			<?php echo $view->getModel()->getName() ?>Store.load({"params" : {"condition" : condition}});
		},
		items: [tb, <?php echo printView($view) ?> ]
	});
	
	page.currentStore = <?php echo $view->getModel()->getName() ?>Store;
	
	map.addBinding({
		shift : true,
		ctrl : true,
		key : "i",
		fn : function(keycode, e) {
			alert("Insert");
		}
	});
	
	return page;
})();
