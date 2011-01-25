<?php
require_once("util/js_converter.php");

$t = new JavaScriptArray();
$t->addRaw("function () {
}");
$t->add("foo's");
$t->add('bar "none"');

echo $t->printOut();

$t = new JavaScriptObject();
$t->addRaw("trevor", "function () {};");
echo $t->printOut();

?>