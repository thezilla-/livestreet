<?php

$config = array();

$config['head']['default']['js'] = Config::Get('head.default.js');
$config['head']['default']['js'][] = '___path.static.skin___/js/init.js';

$config['head']['default']['css'] = array_merge(Config::Get('head.default.css'), array(
	// Template styles
	"___path.static.skin___/css/main.css",
	"___path.static.skin___/css/modals.css",
));


return $config;
?>