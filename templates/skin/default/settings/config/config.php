<?php

$config = array();

/** 
 * Grid type:
 * 
 * fluid - резина
 * fixed - фиксированная ширина
 */
$config['view']['grid']['type'] = 'fluid';

/* Fluid settings */
$config['view']['grid']['fluid_min_width'] = 900;
$config['view']['grid']['fluid_max_width'] = 1200;

/* Fixed settings */
$config['view']['grid']['fixed_width'] = 1000;


$config['head']['default']['js'] = Config::Get('head.default.js');
$config['head']['default']['js'][] = '___path.static.skin___/js/init.js';

$config['head']['default']['css'] = array_merge(Config::Get('head.default.css'), array(
	// Template styles
	"___path.static.skin___/css/main.css",
	"___path.static.skin___/css/modals.css",
));


return $config;
?>