$(document).ready(function(){
	var hoverstatus = [];
	var offX = 10;
	var offY = 10;
	$(".define_me")
		.live("mouseenter", function(e){
			var name = $(this).text();
			hoverstatus[name] = 1;
			if($("#definition_"+name).length){
				$("#definition_"+name).fadeIn("fast");
			}else{
				$.get(
					"/definitions/"+name,
					function(data){
						var def = $(data).find(".definition_holder").first().prependTo("body").hide().attr("id", "definition_"+name)
						if(hoverstatus[name]){
							def
								.fadeIn("fast")
								.css("position", "absolute")
								.css("top", (e.pageY + offY) + "px")
								.css("left", (e.pageX + offX) + "px");
						}
					}
				);
			}
		})
		.live("mousemove", function(e){
			var name = $(this).text();
			$("#definition_"+name)
				.css("top", (e.pageY + offY) + "px")
				.css("left", (e.pageX + offX) + "px");
		})
		.live("mouseleave", function(){
			var name = $(this).text();
			hoverstatus[name] = 0;
			$("#definition_"+name).trigger("goaway");
		});
	$(".definition_holder").live("goaway",function(){
		$(this).fadeOut("slow");
	});
});
