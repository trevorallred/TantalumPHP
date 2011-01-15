<?php
/**
 * @param Model $model
 * @param boolean $root
 */
function printStore($model, $root) {
	?>
	var saveQueue = new Object();
	var writer = new Ext.data.JsonWriter({});
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
			xtype: 'editorgrid',
			height : 100,
			defaults : {
				sortable : true
			},
			stripeRows : true,
			sm : new Ext.grid.RowSelectionModel( {
				listeners : {
					rowselect : {
						fn : function(sm, index, record) {
							page.currentStore = <?php echo $view->getModel()->getName() ?>Store;
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
					echo "{
						header: '" . $field->data["label"] ."',
						xtype : 'gridcolumn',
						width : 150,
						dataIndex : '" . $field->data["name"] ."',
						editor : {
							xtype : 'textfield'
						}
					}";
					$started = true;
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
	<?php
	printStore($view->getModel(), true);
	?>
	<?php echo $view->getModel()->getName() ?>Store.load();
	
	var page = new Ext.Container({
		currentStore : null,
		height : 300,
		title : '<?php echo $view->data["label"] ?>',
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
					if (this.currentStore === null)
						return;
					<?php echo $view->getModel()->getName() ?>Store.removeAt(0);
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
