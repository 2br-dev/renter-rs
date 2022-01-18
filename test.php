<?php
require_once('setup.inc.php');
//$dop = \RS\Orm\Request::make()
//    ->from(new \Kirova\Model\Orm\Additional())->exec()->fetchAll();
$dop = new \Kirova\Model\Orm\Additional(1);
$config = \RS\Config\Loader::byModule('kirova');
echo '<pre>';
var_dump(intval('06'));
var_dump($config['day_with_discount']);
exit();
