<?php

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
	if ($model->getPrimaryKey()) {
		$config->add("idProperty", $model->getPrimaryKey()->getName());
	}
	
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
					<?php echo $childModel->getName()."Store.filter('".$childModel->getParentReference()->getFromField()->getName()."', ".$model->getName()."Store.getAt(0).data.".$childModel->getParentReference()->getToField()->getName()."); "; ?>
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
	
	<?php
	
	if ($model->parent == NULL) {
		echo $model->getName() . "Store.load();\n";
	}
}
?>