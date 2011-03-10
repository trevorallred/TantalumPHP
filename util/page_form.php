<?php

/**
 * @param View $view
 */
function createForm($view) {
	$config = new JavaScriptObject();
	//$config->add("boundRecord", null);
	$config->add("border", TRUE);
	$config->add("padding", 5);
	$config->add("title", $view->getName());
	$modelName = $view->getModel()->getName();
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
	
	<?php echo $view->getModel()->getName() ?>Store.on('load', function() {
		Position<?php echo $view->getModel()->getName() ?>Store(0);
	});
	
	function Position<?php echo $view->getModel()->getName() ?>StoreChange(direction) {
		var record = <?php echo $view->getModel()->getName() ?>Store.currentRow;
		if (record) {
			var index = <?php echo $view->getModel()->getName() ?>Store.indexOf(record);
			Position<?php echo $view->getModel()->getName() ?>Store(index + direction);
		}
	}
	
	function Position<?php echo $view->getModel()->getName() ?>Store(index) {
		var view = <?php echo $view->getName() ?>View;
		var store = <?php echo $view->getModel()->getName() ?>Store;
		var record = store.data.items[index];
		if (record) {
			view.getForm().loadRecord(record);
			store.currentRow = record;
			
			<?php 
			foreach ($view->getModel()->childModels as $childModel) {
				$reference = $childModel->getParentReference();
				$from = $reference->getFromField();
				$to = $reference->getToField();
				echo $childModel->getName()."Store.filter('".$reference->getFromField()->getName()."', record.data.".$reference->getToField()->getName()."); ";
			}
			?>
		}
	}
	
	function Delete<?php echo $view->getModel()->getName() ?>Store() {
		var rows = <?php echo $view->getName() . "View" ?>.selModel.getSelections();
		<?php echo $view->getModel()->getName() ?>Store.remove(rows);
	}

	function Add<?php echo $view->getModel()->getName() ?>Store() {
		var store = <?php echo $view->getModel()->getName() ?>Store;
		var grid = <?php echo $view->getName() ?>View;
		var obj = store.recordType;
		var o = new obj({ });
		<?php
		foreach ($view->getModel()->fields as $field) {
			$field_default = $field->data["defaultFieldName"];
			if (strlen($field_default) > 0) {
				$view->getModel()->findField($columnID);
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