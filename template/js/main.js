( function( $ ) {
	$( '#pane_tab' ).toggle(
		function() {
			$( 'div#marque_pane' ).animate({
				top: 150
			}, 550 );
		}, function() {
			$( 'div#marque_pane' ).animate({
				top: -100
			}, 250 );
		}
	);	

	$( '.flexslider' ).flexslider({
		animation: 'slide'
	});
})( jQuery );