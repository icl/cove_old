<<<<<<< HEAD




/***********************************/
/* JS adjustments for show.html */


$(document).ready(function(){
	$(".show_tags p").click(function(){
		$("show_tags ul").slideToggle("slow");
	});
});
	

















/* end style adjustments for show.html */
/***************************************/
=======
$(document).ready(function(){
	var hoverstatus = [];
	var offX = 10;
	var offY = 10;
	$(".define_me")
		.live("mouseenter lookup", function(e){
			var name = $(this).text();
			hoverstatus[name] = 1;
			if($("#definition_"+name.replace(" ", "_")).length){
				$("#definition_"+name.replace(" ", "_")).fadeIn("fast");
			}else{
				$.get(
					"/definitions/"+name,
					function(data){
						var def = $(data).find(".definition_holder").first().prependTo("body").hide().attr("id", "definition_"+name.replace(" ", "_"))
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
			$("#definition_"+name.replace(" ", "_"))
				.css("position", "absolute")
				.css("top", (e.pageY + offY) + "px")
				.css("left", (e.pageX + offX) + "px");
		})
		.live("mouseleave", function(){
			var name = $(this).text();
			hoverstatus[name] = 0;
			$("#definition_"+name.replace(" ", "_")).trigger("goaway");
		});
	$(".definition_holder").live("goaway",function(){
		$(this).fadeOut("fast");
	});
});
>>>>>>> 9e961e12da75f939b8561aae54b3c14a4df4c54c
