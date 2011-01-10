(function() {
	var page = new Ext.Container({
		title : 'Test Page',
		autoScroll:true,
		items: [{
        	xtype: 'toolbar',
    		items: [{
    			text: 'Search'
    		},{
    			text: 'Save'
    		},{
    			text: 'Delete'
    		},
    		'->', // same as {xtype: 'tbfill'}, // Ext.Toolbar.Fill
    		{
    			text: 'Previous'
    		},{
    			text: 'Next'
    		}]
		},{
        	xtype: 'panel',
        	items: [{
        	}]
		},{
        	xtype: 'form',
        	border: true,
        	items: [
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Last', name: 'LastName' },
				{ xtype: 'textfield', fieldLabel: 'Middle', name: 'MiddleName' }
			]
        }]
	});

	return page;
})();
