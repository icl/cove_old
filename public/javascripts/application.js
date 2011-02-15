$(document).ready(function(){
	$(".define_me")
		.live("mouseenter", function(){
			$.get(
				"/definitions/"+$(this).text(),
				function(data){
					$(data).find(".definition_holder").first().prependTo("body").hide().show("slow");
				}
			);
		})
		.live("mouseleave", function(){
			$(".definition_holder").trigger("goaway");
		});
	$(".definition_holder").live("goaway",function(){
		$(this).hide("slow", function(){
			$(this).remove();
		});
	});
});
