/* Definition Function */




/***********************************/
/* JS adjustments for show.html */


		$(document).ready(function(){  //show more info
			$(".show_moreinfo_button").click(function(){
				$(".show_more_data").slideToggle("slow");
			});
		});
		
		$(document).ready(function(){  //click on add for phenomena
			$(".show_add_phen_button").click(function(){
				$(".show_add_phen_list").slideToggle("slow");
				$(".show_applied_phen").remove();
				$(".show_codingterms_people").remove();
				$(".show_applied_people").remove();
			});
		});
		
		$(document).ready(function(){  //click on add for people
			$(".show_add_people_button").click(function(){
				$(".show_add_people_list").slideToggle("slow");
				$(".show_applied_phen").remove();
				$(".show_codingterms_phen").remove();
				$(".show_applied_people").remove();
			});
		});
		
		$(document).ready(function(){  //click on add for tags
			$(".show_add_tags_button").click(function(){
				$(".show_tags_create").slideToggle("slow");
				$(".show_applied_tags").remove();
			});
		});
	

















/* end style adjustments for show.html */
/***************************************/


$(document).ready(function(){
	
	// --------------------------------
	// .define_me
	// --------------------------------
	var hoverstatus = [];
	var offX = 4;
	var offY = 0;
	var zindex_inc = 1000;
	var delay = 200;
	$(".define_me")
		.live("mouseenter lookup", function(e){
			var name = $(this).text();
			var offset = $(this).offset();
			var width = $(this).width();
			hoverstatus[name] = 1;
			if($("#definition_"+name.replace(" ", "_")).length){
				$(this).oneTime(delay, function(){
					if(hoverstatus[name] == 1){
						$("#definition_"+name.replace(" ", "_")).fadeIn("fast");
					}
				});
			}else{
				$(this).oneTime(delay, function(){
					if(hoverstatus[name] == 1){
						hoverstatus[name] = 2;
						if($("#definition_"+name.replace(" ", "_")).length){
							$("#definition_"+name.replace(" ", "_"))
								.fadeIn("fast")
								.css("position", "absolute")
								.css("top", (offset.top + offY) + "px")
								.css("left", (offset.left + width + offX) + "px");
						}
					}
				});
				$.get(
					"/definitions/"+name,
					function(data){
						var def = $(data)
							.find(".definition_holder")
							.first()
							.prependTo("body")
							.css("z-index", zindex_inc++)
							.hide()
							.attr("id", "definition_"+name.replace(" ", "_"));
						if(hoverstatus[name] == 2){
							def
								.fadeIn("fast")
								.css("position", "absolute")
								.css("top", (offset.top + offY) + "px")
								.css("left", (offset.left + width + offX) + "px");
						}
					}
				);
			}
		})
		.live("mousemove", function(e){
			var name = $(this).text();
			var offset = $(this).offset();
			var width = $(this).width();
			$("#definition_"+name.replace(" ", "_"))
				.css("position", "absolute")
				.css("top", (offset.top + offY) + "px")
				.css("left", (offset.left + width + offX) + "px");
		})
		.live("mouseleave", function(){
			var name = $(this).text();
			hoverstatus[name] = 0;
			$("#definition_"+name.replace(" ", "_")).trigger("goaway");
		});
	$(".definition_holder").live("goaway",function(){
		$(this).fadeOut("fast");
	});
	
	// --------------------------------
	// Fauxselect Menus
	// --------------------------------
	$(".fauxselect_button").live("click openme", function(){
		$(this).parent().find(".fauxselect").toggle("blind",{},"fast");
	});
	$(".fauxselect").hide();
});

