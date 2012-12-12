<?php

require 'functions.php';

$page = isset( $_REQUEST['page'] ) ? $_REQUEST['page'] : 'home';

// Security feature: if user writes unknown page in URL, site will go to home page
switch( $page )
{
	case 'home' :
		break;
	case 'marque' :
		break;
	default :
		$page = 'home';
}

define( "SAS_HTML_DIR", "http://proj-sas.loc/sas/HTML/");

include( "controllers/{$page}.php" );