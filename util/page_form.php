<?php

/**
 * @param View $view
 */
function createForm($view) {
	$config = new JavaScriptObject();
	$config->add("boundRecord", null);
	$config->add("border", TRUE);
	$config->add("padding", 5);
	$config->add("title", $view->getName());
	$modelName = $view->model->getName();
	$items = new JavaScriptArray();
	$config->add("items", $items);
	// $items->add(new JavaScriptObject("fieldLabel", "Test"));
	foreach ($view->getFields() as $field) {
		$fieldJS = new JavaScriptObject();
		$items->add($fieldJS);
		if ($field->data["editable"] == 0) {
			$fieldJS->add("xtype", "displayfield");
		} else {
			$fieldJS->add("xtype", "textfield");
			$fieldJS->addRaw("listeners", "{
				change: function(field) {
		        	${modelName}Store.currentRow.set(field.name, field.getValue());
				}
		    }");
			$fieldJS->add("bubbleEvents", "['change']");
		}
		$fieldJS->add("fieldLabel", $field->data["label"]);
		$fieldJS->add("name", $field->data["name"]);
	}
	?>
	
	var <?php echo $view->getName() ?>View = new Ext.FormPanel(
		<?php echo $config->printOut() ?>
	);
	
	<?php echo $view->model->getName() ?>Store.on('load', function() {
		Position<?php echo $view->model->getName() ?>Store(0);
	});
	
	function Position<?php echo $view->model->getName() ?>StoreChange(direction) {
		var record = <?php echo $view->model->getName() ?>Store.currentRow;
		if (record) {
			var index = <?php echo $view->model->getName() ?>Store.indexOf(record);
			Position<?php echo $view->model->getName() ?>Store(index + direction);
		}
	}
	
	function Position<?php echo $view->model->getName() ?>Store(index) {
		var view = <?php echo $view->getName() ?>View;
		var store = <?php echo $view->model->getName() ?>Store;
		var record = store.data.items[index];
		if (record) {
			view.getForm().loadRecord(record);
			store.currentRow = record;
		}
	}
	
	function Delete<?php echo $view->model->getName() ?>Store() {
		var rows = <?php echo $view->getName() . "View" ?>.selModel.getSelections();
		<?php echo $view->model->getName() ?>Store.remove(rows);
	}

	function Add<?php echo $view->model->getName() ?>Store() {
		var store = <?php echo $view->model->getName() ?>Store;
		var grid = <?php echo $view->getName() ?>View;
		var obj = store.recordType;
		var o = new obj({ });
		<?php
		foreach ($view->model->fields as $field) {
			$field_default = $field->data["defaultFieldName"];
			if (strlen($field_default) > 0) {
				$view->model->findField($columnID);
				echo "o.data.".$field->getName()." = store.parentStore.currentRow.data.".$field_default.";
				";
			}
		}
		?>
		grid.stopEditing();
		
		var size = store.data.length;
		store.insert(size, o);
	 	grid.startEditing(size, 1);
	}
	
	<?php
}
?>