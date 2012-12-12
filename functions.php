<?php

function view( $path, $data = null )
{
	if( $data ) extract( $data );
	$content = "views/{$path}.php";
	include 'views/layout/layout.php';
}