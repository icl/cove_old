$(document).ready(function(){
	$(".define_me")
		.live("mouseenter", function(){
			$.get(
				"/definitions/"+$(this).text(),
				function(data){
					$(data).find(".definition_holder").first().appendTo(".content");
				}
			);
		})
		.live("mouseleave", function(){
			$(".definition_holder").trigger("goaway");
		});
	$(".definition_holder").live("goaway",function(){
		$(this).hide(2, function(){
			$(this).remove();
		});
	});
});
