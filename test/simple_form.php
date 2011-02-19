<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css"
	href="../ext/resources/css/ext-all.css">
<link rel="stylesheet" type="text/css"
	href="../themes/default/icons.css" />
<link rel="stylesheet" type="text/css"
	href="../themes/default/application.css">
<link rel="shortcut icon" type="text/css"
	href="../themes/default/application.ico" />
<script type="text/javascript" src="../ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../ext/ext-all-debug.js"></script>
<script type="text/javascript" src="../js/Ext.ux.data.BindMgr.js"></script>
<script type="text/javascript">
Ext.BLANK_IMAGE_URL = '../ext/resources/images/default/s.gif';

Ext.onReady(function() {
	var bd = Ext.getBody();
	
	var gridForm = new Ext.FormPanel({
            title:'Company details',
            defaultType: 'textfield',
            items: [{
                id: 'CompanyName',
                fieldLabel: 'Name',
                name: 'company'
            },{
                id: 'CompanyPrice',
                fieldLabel: 'Price',
                name: 'price'
            },{
                xtype: 'button',
                text: 'Click Me',
                handler: function() {
                	var field = gridForm.getComponent("CompanyName");
                    alert(field.getValue());
                }
            }],
        renderTo: bd
    });
});

</script>
<title>Simple Test</title>
</head>
<body>


</body>
</html>
