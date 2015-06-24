$(document).ready( function(){
	$(".table-list tr:has(.property-image)").css('height','auto');
	$(".property-list tr:has(.property-image)").css('height','auto');
	$(".button").hover(
		function(){ $(this).addClass("button-over");},
		function(){ $(this).removeClass("button-over");}
	);
	
	$('a').bind( 'focus', function(){this.blur();});
});