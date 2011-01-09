<?php
function test() {
	$view = new View();
}
?>
(function() {
	Tantalum.<?php echo $view->model->getName() ?>Store = Ext.extend(Ext.data.JsonStore, {
		constructor : function(cfg) {
			cfg = cfg || {};
			Tantalum.<?php echo $view->model->getName() ?>Store.superclass.constructor.call(this, Ext.apply( {
				url : 'data.php?id=<?php echo $view->model->getId() ?>',
				root : '<?php echo $view->model->getName() ?>',
				idProperty : '<?php echo $view->model->getPrimaryKey()->getName() ?>',
				fields : [ <?php
					$started = false;
					foreach ($view->model->fields as $field) {
						echo $started ? ", " : "";
						echo "{ name: '" . $field->getName() ."'}";
						$started = true;
					}
				?> ]
			}, cfg));
		}
	});
	var <?php echo $view->model->getName() ?>Store = new Tantalum.<?php echo $view->model->getName() ?>Store();
	<?php echo $view->model->getName() ?>Store.load();
	
	var page = new Ext.grid.EditorGridPanel( {
		defaults : {
			sortable : true
		},
		stripeRows : true,
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
		store : <?php echo $view->model->getName() ?>Store,
		title : '<?php echo $view->data["label"] ?>'
	});

	return page;
})();
