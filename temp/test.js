(function() {
	var saveQueue;
	var writer = new Ext.data.JsonWriter({});

	Tantalum.ManageTablesStore = Ext.extend(Ext.data.JsonStore, {
		constructor : function(cfg) {
			cfg = cfg || {};
			Tantalum.ManageTablesStore.superclass.constructor.call(this, 
				Ext.apply({
					"url": "data.php?id=095e0687-9f58-11df-936f-e37ecc873ea2",
					"writer": writer,
					"autoSave": false,
					"root": "ManageTables", 
					"idProperty": "ManageTablesTableID", 
					"fields": [{
						"name": "ManageTablesTableID"
					},{
						"name": "ManageTablesName",
						"sortType": "asUCText"
					},{
						"name": "ManageTablesDatabaseName"
					}]
				},
				cfg)
			);
		}
	});
	var ManageTablesStore = new Tantalum.ManageTablesStore();

	ManageTablesStore.load();
	
	var ListTablesView = new Ext.grid.EditorGridPanel(
		{
			"title": "List Tables",
			"flex": 10,
			"stripeRows": true, 
			"store": ManageTablesStore,
			"columns": [{
				"sortable": true,
            	"header": "Table name",
            	"dataIndex": "ManageTablesName",
            	"editor": {"xtype": "textfield"}
			},{
				"sortable": true,
				"header": "DB name",
				"dataIndex": "ManageTablesDatabaseName", 
            	"editor": {"xtype": "textfield"}
            }]
		}
	);
	
	ListTablesView.addListener('afteredit', function(e) {
		if (e.field == "ManageTablesName") {
			e.record.data.ManageTablesDatabaseName = 'tan_' + e.value.toLowerCase();
			e.record.endEdit();
		}
	});
	
	var page = new Ext.Panel({
		title : 'List Tables',
		layout : 'vbox',
		layoutConfig : {
		    align : 'stretch',
		    flex : 1
		},
		items: [ListTablesView]
	});
	
	return page;
})();
