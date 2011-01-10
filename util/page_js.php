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
	<?php
	foreach ($model->childModels as $childModel) {
		printStore($childModel, false);
	}
}

/**
 * @param View $view
 */
function printView($view) {
	echo ", {";
	
	if ($view->data["viewType"] == "HorizontalContainer") {
		
	} else if ($view->data["viewType"] == "BasicTable") {
		?>
		xtype: 'editorgrid',
		defaults : {
			sortable : true
		},
		stripeRows : true,
		autoScroll:true,
		autoHeight: true,
		columns : [ <?php
			$started = false;
			foreach ($view->getFields() as $field) {
				echo $started ? ", " : "";
				echo "{
					header: '" . $field->data["label"] ."',
					xtype : 'gridcolumn',
					sortable : true,
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
		store : <?php echo $view->model->getName() ?>Store
		<?php
	} else {
		?>
		xtype: 'form',
		border: true,
		items: [
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
		<?php
	}
	echo "}";
	foreach ($view->childViews as $childView) {
		//printView($childView);
	}
}
?>
(function() {
	<?php
	printStore($view->model, true);
	?>
	<?php echo $view->model->getName() ?>Store.load();
	
	var page = new Ext.Container({
		title : '<?php echo $view->data["label"] ?>',
		items: [{
        	xtype: 'toolbar',
    		items: [{
    			text: 'Search'
    		},{
    			text: 'Refresh'
    		},{
    			text: 'Save'
    		},{
    			text: 'Delete'
    		},
    		'->', // same as {xtype: 'tbfill'}, // Ext.Toolbar.Fill
    		{
    			text: '<< Previous'
    		},{
    			text: 'Next >>'
    		}]
		}
		<?php printView($view) ?>
		]
	});

	return page;
})();
