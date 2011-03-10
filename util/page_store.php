<?php

/**
 * @param Model $model
 */
function createStore($model) {
	$config = new JavaScriptObject();
	if ($model->parent == NULL) {
		$autoQuery = true;
		$url = "data.php?id=" . $model->getId();
		if (isset($_REQUEST["filter"])) {
			$url .= "&condition=" . urlencode($_REQUEST["filter"]);
		}
		$config->add("url", $url);
	} else {
		$config->addRaw("parentStore", $model->parent->getName() . "Store");
	}
	$config->addRaw("views", "{}");
	$config->add("autoDestroy", true);
	$config->add("totalProperty", "totalCount");
	$config->add("batch", true);
	$config->add("autoSave", false);
	$config->add("pruneModifiedRecords", true);
	$config->add("writer", "writer", JavaScriptValue::RAW);
	$config->add("root", $model->getName());
	if ($model->getPrimaryKey()) {
		$config->add("idProperty", $model->getPrimaryKey()->getName());
	}
	
	$fields = new JavaScriptArray();
	
	$sortField = null;
	$lowestOrder = 0;
	foreach ($model->fields as $field) {
		$sortOrder = $field->data["sortOrder"];
		if ($sortOrder > 0 && ($lowestOrder == 0 || $sortOrder < $lowestOrder)) {
			$sortField = $field;
			$lowestOrder = $sortOrder;
		}
		
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
	
	if ($sortField != null) {
		$sort = new JavaScriptObject();
		$sort->add("field", $sortField->data["name"]);
		$sort->add("direction", "ASC");
		$config->add("sortInfo", $sort);
	}
	$config->add("currentRow", NULL);
	$config->addRaw("filterChildren", "filter" . $model->getName() . "Children");
	
	?>
	function filter<?php echo $model->getName() ?>Children() {
		alert("asdf");
	}
	
	Tantalum.<?php echo $model->getName() ?>Store = Ext.extend(Ext.data.JsonStore, {
		constructor : function(cfg) {
			cfg = cfg || {};
			Tantalum.<?php echo $model->getName() ?>Store.superclass.constructor.call(this, 
				Ext.apply(<?php echo $config->printOut() ?>, cfg));
		}
	});
	var <?php echo $model->getName() ?>Store = new Tantalum.<?php echo $model->getName() ?>Store();
	
	<?php echo $model->getName() ?>Store.addListener('beforewrite', function(store, action, rs, options) {
		store.saveQueue[action] = [];
		if (Ext.isArray(rs)) {
			store.saveQueue[action] = rs;
		} else {
			store.saveQueue[action].push(rs);
		}
		return false;
	});
	
	<?php
	if (count($model->childModels) > 0) {
		?>
		<?php echo $model->getName() ?>Store.on('load', function(store) {
			<?php
			foreach ($model->childModels as $childModel) {
				if ($childModel->getParentReference() != null) {
					?>
					<?php echo $childModel->getName() ?>Store.loadData(<?php echo $model->getName() ?>Store.reader.jsonData);
					if (<?php echo $model->getName() ?>Store.getCount() > 0) {
						<?php echo $childModel->getName()."Store.filter('".$childModel->getParentReference()->getFromField()->getName()."', ".$model->getName()."Store.getAt(0).data.".$childModel->getParentReference()->getToField()->getName()."); "; ?>
					}
					<?php
				}
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
		var dirty = false;
		var savejson = new Object();
		var savejsonModel = new Object();
		<?php echo $model->getName() ?>Store.saveQueue = new Object();
		<?php echo $model->getName() ?>Store.save();
		
		for ( var action in <?php echo $model->getName() ?>Store.saveQueue) {
			if (Ext.isDefined(action)) {
				savejsonModel[action] = [];
				for ( var i = 0; i < <?php echo $model->getName() ?>Store.saveQueue[action].length; i++) {
					savejsonModel[action].push(<?php echo $model->getName() ?>Store.saveQueue[action][i].data);
					dirty = true;
				}
			}
		}
		savejson['<?php echo $model->getName() ?>'] = savejsonModel;
		
		if (dirty) {
			Ext.Ajax.request( {
				url : 'data.php',
				method: 'POST',
				success : function(response, opts) {
					var obj = Ext.decode(response.responseText);
	
					if (obj.success === false) {
						alert(obj.error_message);
						return;
					}
					for ( var action in <?php echo $model->getName() ?>Store.saveQueue) {
						if (Ext.isDefined(action)) {
							this['on' + Ext.util.Format.capitalize(action) + 'Records'](true, <?php echo $model->getName() ?>Store.saveQueue[action],
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
		} else {
			<?php
			foreach ($model->childModels as $childModel) {
				echo "save".$childModel->getName()."Store(); ";
			}
			?>
		}
	}
	
	<?php
	if ($model->parent == NULL) {
		// TODO if the URL wasn't set, then don't do this
		echo $model->getName() . "Store.load();\n";
	}
}
?>