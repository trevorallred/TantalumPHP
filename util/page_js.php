<?php
require_once("util/js_converter.php");

/**
 * @param Model $model
 */
function createStore($model) {
	$config = new JavaScriptObject();
	if ($model->parent == NULL) {
		$config->add("url", "data.php?id=" . $model->getId());
	} else {
		$config->addRaw("parentStore", $model->parent->getName() . "Store");
	}
	$config->addRaw("views", "{}");
	$config->add("autoDestroy", true);
	$config->add("batch", true);
	$config->add("autoSave", false);
	$config->add("pruneModifiedRecords", true);
	$config->add("writer", "writer", JavaScriptValue::RAW);
	$config->add("root", $model->getName());
	$config->add("idProperty", $model->getPrimaryKey()->getName());
	
	$sortField = null;
	$lowestOrder = 0;
	foreach ($model->fields as $field) {
		$sortOrder = $field->data["sortOrder"];
		if ($sortOrder > 0 && ($lowestOrder == 0 || $sortOrder < $lowestOrder)) {
			$sortField = $field;
			$lowestOrder = $sortOrder;
		}
	}
	if ($sortField != null) {
		$sort = new JavaScriptObject();
		$sort->add("field", $sortField->data["name"]);
		$sort->add("direction", "ASC");
		$config->add("sortInfo", $sort);
	}
	$config->add("currentRow", NULL);
	
	$fields = new JavaScriptArray();
	foreach ($model->fields as $field) {
		$fieldJS = new JavaScriptObject();
		$fields->add($fieldJS);
		$fieldJS->add("name", $field->getName());
		switch ($field->data["basisColumnType"]) {
			case "Integer":
				$fieldJS->add("type", "integer");
				break;
		}
	}
	$config->add("fields", $fields);
	?>
	Tantalum.<?php echo $model->getName() ?>Store = Ext.extend(Ext.data.JsonStore, {
		constructor : function(cfg) {
			cfg = cfg || {};
			Tantalum.<?php echo $model->getName() ?>Store.superclass.constructor.call(this, 
				Ext.apply(<?php echo $config->printOut() ?>, cfg));
		}
	});
	var <?php echo $model->getName() ?>Store = new Tantalum.<?php echo $model->getName() ?>Store();
	<?php echo $model->getName() ?>Store.addListener('beforewrite', function(store, action, rs, options) {
		saveQueue[action] = [];
		if (Ext.isArray(rs)) {
			saveQueue[action] = rs;
		} else {
			saveQueue[action].push(rs);
		}
		return false;
	});
	<?php
	if (count($model->childModels) > 0) {
		?>
		<?php echo $model->getName() ?>Store.on('load', function(store) {
			<?php
			foreach ($model->childModels as $childModel) {
				?>
				<?php echo $childModel->getName() ?>Store.loadData(<?php echo $model->getName() ?>Store.reader.jsonData);
				if (<?php echo $model->getName() ?>Store.getCount() > 0) {
					<?php echo $childModel->getName() ?>Store.filter('DefineTableColumnTableID', <?php echo $model->getName() ?>Store.getAt(0).data.DefineTableTableID);
				}
				<?php
			}
		?>
		});
		
		<?php
		foreach ($model->childModels as $childModel) {
			createStore($childModel);
		}
	}
	?>
	function save<?php echo $model->getName() ?>Store() {
		var savejson = new Object();
		var savejsonModel = new Object();
		saveQueue = new Object();
		<?php echo $model->getName() ?>Store.save();
		
		for ( var action in saveQueue) {
			if (Ext.isDefined(action)) {
				savejsonModel[action] = [];
				for ( var i = 0; i < saveQueue[action].length; i++) {
					savejsonModel[action].push(saveQueue[action][i].data);
				}
			}
		}
		savejson['<?php echo $model->getName() ?>'] = savejsonModel;
		
		Ext.Ajax.request( {
			url : 'data.php',
			method: 'POST',
			success : function(response, opts) {
				var obj = Ext.decode(response.responseText);

				if (obj.success === false) {
					alert(obj.error_message);
					return;
				}
				for ( var action in saveQueue) {
					if (Ext.isDefined(action)) {
						this['on' + Ext.util.Format.capitalize(action) + 'Records'](true, saveQueue[action],
								obj.<?php echo $model->getName() ?>[action]);
					}
				}
				<?php
				foreach ($model->childModels as $childModel) {
					echo "save".$childModel->getName()."Store(); ";
				}
				?>
			},
			failure : function(response, opts) {
				alert("Failed to save data with status code " + response.status);
			},
			params : {
				action : 'save',
				id : '<?php echo $model->getId() ?>'
			},
			scope : <?php echo $model->getName() ?>Store,
			jsonData : Ext.util.JSON.encode(savejson)
		});
	}
	
	function delete<?php echo $model->getName() ?>Store() {
		var rows = item.grid.selModel.getSelections();
		<?php echo $model->getName() ?>Store.remove(rows);
	}

	function insert<?php echo $model->getName() ?>Store() {
		var store = <?php echo $model->getName() ?>Store;
		var obj = store.recordType;
		var o = new obj({ });
		// o.data.DefineTableColumnDisplayOrder = 1;
		// o.data.DefineTableColumnTableID = store.parentStore.data[store.parentStore.currentRow].DefineTableTableID;
		// if(item.grid != null) {
		//	item.grid.stopEditing();
		// }
		var size = store.data.length;
		store.insert(size, o);
		// if(item.grid != null) {
		// 	item.grid.startEditing(size, 0);
		// }
	}
	
	<?php
	
	if ($model->parent == NULL) {
		echo $model->getName() . "Store.load();\n";
	}
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
function createGrid($view) {
	$config = new JavaScriptObject();
	$config->add("flex", 1);
	$config->add("stripeRows", TRUE);
	$columnDefaults = new JavaScriptObject();
	$columnDefaults->add("xtype", "gridcolumn");
	$columnDefaults->add("width", 120);
	$config->add("defaults", $columnDefaults);
	$config->addRaw("store", $view->getModel()->getName() . "Store");
	$config->addRaw("refresh", "function() {this.store.reload();}");
	
	$smFunction = "page.currentStore = ".$view->getModel()->getName()."Store;
		page.currentSelectionModel = sm; ";
	foreach ($view->getModel()->childModels as $childModel) {
		$smFunction .= $childModel->getName()."Store.filter('DefineTableColumnTableID', record.data.DefineTableTableID); ";
	};
	$config->addRaw("sm", "new Ext.grid.RowSelectionModel( {
		listeners : {
			rowselect : {
				fn : function(sm, index, record) {
					$smFunction
				}
			}
		}
	})");
	
	$columns = new JavaScriptArray();
	$config->add("columns", $columns);
	foreach ($view->getFields() as $field) {
		
		$fieldJS = new JavaScriptObject();
		$columns->add($fieldJS);
		if ($field->data["visible"] == 0)  {
			$fieldJS->add("hidden", TRUE);
		}
		$fieldJS->add("header", $field->data["label"]);
		$fieldJS->add("sortable", TRUE);
		
		$width = 0;
		if ($field->data["size"] > 0) {
			$width = (int)$field->data["size"];
		} else {
			if ($field->data["displayType"] == "Checkbox") {
				$width = 30;
			}
		}
		$minWidth = 20 + (strlen($field->data["label"]) * 5);
		if ($width > 0 && $width < $minWidth) {
			$width = $minWidth;
		}
		if ($width > 0) {
			$fieldJS->add("width", $width);
		}
		
		$fieldJS->add("dataIndex", $field->data["name"]);
		
		if ($field->data["basisColumnType"] == "Integer") {
			$fieldJS->add("xtype", "numbercolumn");
			$fieldJS->add("format", "0");
		}
		
		if ($field->data["editable"] == 1) {
			if ($field->data["editor"]) {
				$fieldJS->addRaw("editor", $field->data["editor"]);
			} else {
				$editor = new JavaScriptObject();
				switch ($field->data["displayType"]) {
					case "Checkbox":
						$fieldJS->add("align", "center");
						break;
					case "Combo":
						break;
					default:
						$editor->add("xtype", "textfield");
						$fieldJS->add("editor", $editor);
				}
			}
		}
		
		if (strlen($field->data["renderer"]) > 0) {
			$fieldJS->addRaw("renderer", $field->data["renderer"]);
		}
	}

	?>
	var <?php echo $view->getName() . "View" ?> = new Ext.grid.EditorGridPanel(
		<?php echo $config->printOut(); ?>
	);
	<?php
}

/**
 * @param View $view
 */
function createForm($view) {
	$config = new JavaScriptObject();
	$config->add("border", TRUE);
	$config->add("title", $view->getName());
	$items = new JavaScriptArray();
	$config->add("items", $items);
	// $items->add(new JavaScriptObject("fieldLabel", "Test"));
	foreach ($view->getFields() as $field) {
		$fieldJS = new JavaScriptObject();
		$items->add($fieldJS);
		$fieldJS->add("xtype", "textfield");
		$fieldJS->add("fieldLabel", $field->data["label"]);
		$fieldJS->add("name", $field->data["name"]);
	}
	?>
	var <?php echo $view->getName() . "View" ?> = new Ext.FormPanel(
		<?php echo $config->printOut() ?>
	);
	<?php
}

/**
 * @param View $view
 */
function printView($view) {
	if ($view->data["viewType"] == "Form") {
		echo ", " . $view->getName() . "View";
	} else if ($view->data["viewType"] == "Grid") {
		echo ", " . $view->getName() . "View";
	} else {
		
	}
	foreach ($view->childViews as $childView) {
		printView($childView);
	}
}
?>
(function() {
	var saveQueue;
	var writer = new Ext.data.JsonWriter({});

	Ext.util.Format.comboRenderer = function(combo){
	    return function(value){
	        var record = combo.findRecord(combo.valueField, value);
	        return record ? record.get(combo.displayField) : combo.valueNotFoundText;
	    }
	}
	
	var combo = new Ext.form.ComboBox({
	    lazyRender: true,
	    mode: 'local',
	    store: new Ext.data.ArrayStore({
	        id: 0,
	        fields: [
	            'value'
	        ],
	        data: [<?php ColumnTypes::printValues() ?>]
	    }),
	    valueField: 'value',
	    displayField: 'value'
	});
	
	<?php
	createStore($view->getModel());
	createView($view);
	?>
	
	var page = new Ext.Container({
		currentStore : null,
		currentSelectionModel : null,
		height : 300,
		title : '<?php echo $view->data["label"] ?>',
		layout : 'vbox',
		layoutConfig : {
		    align : 'stretch'
		},
		items: [{
        	xtype: 'toolbar',
    		items: [{
    			iconCls : 'icon-magnifier',
    			text: 'Search'
    		},{
    			iconCls : 'icon-refresh',
    			handler: function(b, e) {
					<?php echo $view->getModel()->getName() ?>Store.reload();
    			},
    			text: 'Refresh'
    		},{
    			iconCls : 'icon-disk',
    			itemId : 'save',
    			//disabled : true,
    			handler: function(button, event) {
    				save<?php echo $view->getModel()->getName() ?>Store();
    			},
    			text: 'Save'
    		},{
    			iconCls : 'icon-minus',
    			menu : {
	                items: [{
		    			handler: deleteDefineTableStore,
	                    text: 'Delete Table'
	                }, {
		    			handler: deleteDefineTableColumnStore,
	                    text: 'Delete Column'
	                }]
	            },
    			tooltip: {text:'This is a an example QuickTip for a toolbar item', title:'Tip Title'},
    			text: 'Delete'
    		},{
    			iconCls : 'icon-plus',
    			menu : {
	                items: [{
		    			handler: insertDefineTableStore,
	                    text: 'Add Table'
	                }, {
		    			handler: insertDefineTableColumnStore,
	                    text: 'Add Column'
	                }]
	            },
    			text: 'Add'
    		},
    		'->',
    		{
    			iconCls : 'icon-arrow-left',
    			text: 'Previous'
    		},{
    			iconCls : 'icon-arrow-right',
    			iconAlign: 'right',
    			text: 'Next'
    		}]
		}
		<?php printView($view) ?>
		]
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
