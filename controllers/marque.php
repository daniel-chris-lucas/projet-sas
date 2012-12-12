<?php

if( !isset( $_REQUEST['marque'] ) ) header( 'Location: index.php' );

switch( $_REQUEST['marque'] )
{
	case 'aston-martin' :
		$title = 'Aston Martin';
		break;
	case 'bmw' :
		$title = 'BMW';
		break;
	case 'de-tomaso' :
		$title = 'De Tomaso';
		break;
	case 'dodge' :
		$title = 'Dodge';
		break;
	case 'ferrari' :
		$title = 'Ferrari';
		break;
	case 'jaguar' :
		$title = 'Jaguar';
		break;
	case 'lamborghini' :
		$title = 'Lamborghini';
		break;
	case 'maserati' :
		$title = 'Maserati';
		break;
	case 'mercedes' :
		$title = 'Mercedes';
		break;
	case 'porsche' :
		$title = 'Porsche';
		break;
	case 'venturi' :
		$title = 'Venturi';
		break;
	default :
		$title = 'Aston Martin';
}

$view = isset( $_REQUEST['marque'] ) ? $_REQUEST['marque'] : 'aston-martin';
view( "marques/{$view}", array(
	'title' => "Marque &raquo; {$title}",
	'page_title' => $title
));