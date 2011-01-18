<?php
/**
 * @param Model $model
 * @param boolean $root
 */
function printStore($model, $root) {
	?>
	Tantalum.<?php echo $model->getName() ?>Store = Ext.extend(Ext.data.JsonStore, {
		constructor : function(cfg) {
			cfg = cfg || {};
			Tantalum.<?php echo $model->getName() ?>Store.superclass.constructor.call(this, Ext.apply( {
				<?php
				if ($root) {
					echo "url : 'data.php?id=" . $model->getId() ."', ";
				}
				?>
				autoDestroy : true,
				batch : true,
				autoSave : false,
				pruneModifiedRecords : true,
				writer : writer,
				root : '<?php echo $model->getName() ?>',
				idProperty : '<?php echo $model->getPrimaryKey()->getName() ?>',
				fields : [ <?php
					$started = false;
					foreach ($model->fields as $field) {
						echo $started ? ", " : "";
						echo "{ name: '" . $field->getName() ."'}";
						$started = true;
					}
				?> ]
			}, cfg));
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
			printStore($childModel, false);
		}
	}
}

/**
 * @param View $view
 */
function printView($view) {
	if ($view->data["viewType"] == "HorizontalContainer") {
		// echo ", {xtype: 'container',}";
	} else if ($view->data["viewType"] == "BasicTable") {
		?>
		, {
			xtype : 'editorgrid',
			flex : 1,
			defaults : {
				xtype : 'gridcolumn',
				width: 120,
				sortable : true
			},
			stripeRows : true,
			sm : new Ext.grid.RowSelectionModel( {
				listeners : {
					rowselect : {
						fn : function(sm, index, record) {
							page.currentStore = <?php echo $view->getModel()->getName() ?>Store;
							page.currentSelectionModel = sm;
							<?php
							foreach ($view->getModel()->childModels as $childModel) {
								?>
								<?php echo $childModel->getName() ?>Store.filter('DefineTableColumnTableID', record.data.DefineTableTableID);
								<?php
							}
							?>
						}
					}
				}
			}),
			viewConfig : {
			},
			columns : [ <?php
				$started = false;
				foreach ($view->getFields() as $field) {
					echo $started ? ", " : "";
					$started = true;
					
					$json["header"] = $field->data["label"];
					$json["dataIndex"] = $field->data["name"];
					$json["editable"] = $field->data["editable"] == 1 ? "true" : "false";
					switch ($field->data["displayType"]) {
						case "Checkbox":
							$xtype = "checkbox";
							break;
						default:
							$xtype = "textfield";
					}
					$json["editor"]["xtype"] = $xtype;
					
					HtmlUtils::jsonEncode($json);
				}
			?> ],
			refresh : function() {
				this.store.reload();
			},
			store : <?php echo $view->getModel()->getName() ?>Store
		}
		<?php
	} else {
		?>
		, {
			xtype: 'form',
			border: true,
			items: [
				{
					fieldLabel: 'Test',
				},
				<?php
				$started = false;
				foreach ($view->getFields() as $field) {
					echo $started ? ", " : "";
					echo "{
						xtype: 'textfield',
						fieldLabel: '" . $field->data["label"] ."',
						name: '" . $field->data["name"] ."'
					}";
					$started = true;
				}
				?>
			]
		}
		<?php
	}
	foreach ($view->childViews as $childView) {
		printView($childView);
	}
}
?>
(function() {
	var saveQueue = new Object();
	var writer = new Ext.data.JsonWriter({});
	
	<?php
	printStore($view->getModel(), true);
	?>
	<?php echo $view->getModel()->getName() ?>Store.load();
	
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
    			disabled : true,
    			handler: function(button, event) {
					var savejson = new Object();
					var savejsonModel = new Object();
					saveQueue = new Object();
					<?php echo $view->getModel()->getName() ?>Store.save();
					for ( var action in saveQueue) {
						if (Ext.isDefined(action)) {
							savejsonModel[action] = [];
							for ( var i = 0; i < saveQueue[action].length; i++) {
								savejsonModel[action].push(saveQueue[action][i].data);
							}
						}
					}
					savejson['<?php echo $view->getModel()->getName() ?>'] = savejsonModel;
					
					Ext.Ajax.request( {
						url : 'data.php',
						method: 'POST',
						success : function(response, opts) {
							var obj = Ext.decode(response.responseText);
		
							if (obj.success === false) {
								alert("Failed to save data");
								return;
							}
							for ( var action in saveQueue) {
								if (Ext.isDefined(action)) {
									this['on' + Ext.util.Format.capitalize(action) + 'Records'](obj.success, saveQueue[action],
											obj.<?php echo $view->getModel()->getName() ?>[action]);
								}
							}
						},
						failure : function(response, opts) {
							alert("Failed to save data with status code " + response.status);
						},
						params : {
							action : 'save',
							id : '<?php echo $view->getModel()->getId() ?>'
						},
						scope : <?php echo $view->getModel()->getName() ?>Store,
						jsonData : Ext.util.JSON.encode(savejson)
					});
    			},
    			text: 'Save'
    		},{
    			iconCls : 'icon-minus',
    			handler: function(b, e) {
    				if (page.currentStore == null)
						return;
					var rows = page.currentSelectionModel.getSelections();
					page.currentStore.remove(rows);
    			},
    			text: 'Delete'
    		},{
    			iconCls : 'icon-plus',
    			handler: function(b, e) {
					if (this.currentStore === null)
						return;
					<?php echo $view->getModel()->getName() ?>Store.reload();
    			},
    			text: 'Add'
    		},
    		'->', // same as {xtype: 'tbfill'}, // Ext.Toolbar.Fill
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
	return page;
})();
