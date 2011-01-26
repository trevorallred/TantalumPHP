<?php
require_once("util/js_converter.php");

$t = new JavaScriptArray();
$t->add("foo");
$t->add('bar');

$s = $t;
$s->addAll($t);

echo $s->printOut();

?>