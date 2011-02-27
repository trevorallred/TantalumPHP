(function() {
	var writer = new Ext.data.JsonWriter({});

	Tantalum.ListModelsStore = Ext.extend(Ext.data.JsonStore, {
		constructor : function(cfg) {
			cfg = cfg || {};
			Tantalum.ListModelsStore.superclass.constructor.call(this, 
				Ext.apply({
					"url": "data.php?id=095e1122-9f58-11df-936f-e37ecc873ea2", "views": {}, "autoDestroy": true, "batch": true, 
					"autoSave": false, "pruneModifiedRecords": true, "writer": writer, 
					"root": "ListModels", "idProperty": "ListModelModelID", 
					"sortInfo": {"field": "ListModelParentID", "direction": "ASC"}, 
					"fields": [{
						"name": "ListModelModelID"
					},{
						"name": "ListModelName"},{"name": "ListModelBasisTableID"},{"name": "ListModelBasisTableName"},{
						"name": "ListModelParentID"},{"name": "ListModelReferenceID"},{
						"name": "ListModelResultsPerPage", "type": "integer"
					}]
				}, cfg));
		}
	});
	var ListModelsStore = new Tantalum.ListModelsStore();
	ListModelsStore.load();
	
	var ListModelsView = new Ext.grid.EditorGridPanel(
		{
			"title": "List Models", "flex": 10, "stripeRows": true, 
			"store": ListModelsStore, 
			"columns": [{
				"header": "Model ID", "sortable": true, "width": 225, "dataIndex": "ListModelModelID", "editor": {"xtype": "textfield"}
			},{
				"header": "Model Name", "sortable": true, "dataIndex": "ListModelName", "editor": {"xtype": "textfield"}
			},{
				"header": "BasisTableID", "sortable": true, "width": 220, "dataIndex": "ListModelBasisTableID", "editor": {"xtype": "textfield"}
			},{
				"header": "Basis Table", 
				"sortable": true, 
				"dataIndex": "ListModelBasisTableName", 
				"editor": new Ext.form.ComboBox({
					lazyRender: true,
					triggerAction: 'all',
					mode: 'remote',
					store: new Ext.data.JsonStore({
				    	autoDestroy: true,
				        fields: ['ManageTablesTableID','ManageTablesName','ManageTablesDatabaseName'],
				        url: 'data.php?id=095e0687-9f58-11df-936f-e37ecc873ea2',
						root: 'ManageTables',
						idProperty: 'ManageTablesTableID'
				    }),
					displayField: 'ManageTablesName',
					queryParam: 'query[ManageTablesName]',
					listeners:{
						'select': function(combo, record) {
							this.gridEditor.record.data.ListModelBasisTableID = record.data.ManageTablesTableID;
						}
					}
				})
			}]
		}
	);
	
	var page = new Ext.Panel({
		currentStore : null,
		title : 'List Models',
		layout : 'vbox',
		layoutConfig : {
		    align : 'stretch',
		    flex : 1
		},
		filter : function(condition) {
			ListModelsStore.load({"params" : {"condition" : condition}});
		},
		items: [ListModelsView ]
	});
	
	return page;
})();
