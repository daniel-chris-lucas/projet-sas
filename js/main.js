( function( $ ) {

	$( '#pane_tab' ).toggle(
		function() {
			$( 'div#marque_pane' ).animate({
				top: 150
			}, 550 );
		}, function() {
			$( 'div#marque_pane' ).animate({
				top: -199
			}, 250 );
		}
	);


	$( '.flexslider' ).flexslider({
		animation: 'slide',
		controlNav: false,
		directionNav: false
	});


	/*var iFrames = $('iframe');
      
    function iResize() {    	
    	for (var i = 0, j = iFrames.length; i < j; i++) {
    		iFrames[i].style.height = iFrames[i].contentWindow.document.body.offsetHeight + 'px';
    	}
    }

    console.log( 'resize frame before' );
    if ($.browser.safari || $.browser.opera) {
    	console.log( 'if' );         	
    	iFrames.load(function(){
    	    setTimeout(iResize, 0);
        });
        
    	for (var i = 0, j = iFrames.length; i < j; i++) {
    		var iSource = iFrames[i].src;
    		iFrames[i].src = '';
    		iFrames[i].src = iSource;
        }               
    } else {
    	console.log( 'else' );
    	iFrames.load(function() { 
    		this.style.height = this.contentWindow.document.body.offsetHeight + 'px';
    	});
    }
    console.log( 'resize frame end' );*/

})( jQuery );