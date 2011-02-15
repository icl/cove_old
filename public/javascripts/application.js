$(document).ready(function(){
	var hoverstatus = [];
	$(".define_me")
		.live("mouseenter", function(){
			var name = $(this).text();
			hoverstatus[name] = 1;
			if($("#definition_"+name).length){
				$("#definition_"+name).show("fast");
			}else{
				$.get(
					"/definitions/"+name,
					function(data){
						var def = $(data).find(".definition_holder").first().prependTo("body").hide().attr("id", "definition_"+name)
						if(hoverstatus[name]){
							def.show("fast");
						}
					}
				);
			}
		})
		.live("mouseleave", function(){
			var name = $(this).text();
			hoverstatus[name] = 0;
			$("#definition_"+name).trigger("goaway");
		});
	$(".definition_holder").live("goaway",function(){
		$(this).hide("slow");
	});
});
