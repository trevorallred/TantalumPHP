Ext.ns('Tantalum');
Ext.BLANK_IMAGE_URL = 'ext-3.3.1/resources/images/default/s.gif';

BodyPanel = Ext.extend(Ext.Viewport, {
	layout : 'border',

	initComponent : function() {
		this.items = [ {
			xtype : 'tantalum-menu'
		}, {
			xtype : 'tabpanel',
			id : 'contentPanel',
			activeTab : 0,
			region : 'center',
			defaults : {
				closable : true
			},
			items : [ {
				xtype : 'panel',
				title : 'Welcome',
				html : '<div class="welcome">Welcome to Tantalum</div>'
			} ]
		} ];
		BodyPanel.superclass.initComponent.call(this);

		this.menu = this.items.itemAt(0);
		this.content = this.items.itemAt(1);
	}
});

var map;

Ext.onReady(function() {
	Ext.QuickTips.init();

	var bodyPanel = new BodyPanel();

	map = new Ext.KeyMap(document);
});
