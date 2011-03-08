/* Thumbnail fast scrub */    
    function changeSpriteWindow(obj){
        //TODO: figure out how to grab misc 10 pixel additional margin
        var extra_margin =10;
        var newY = (event.clientX-($(obj).position().left)-extra_margin)*90;
        var position = "0px " + newY + "px "
        obj.style.backgroundPosition = position;
    }
    
    $('.thumbnail_box').live('mousemove', function(event) {
        changeSpriteWindow(this);
    });
    
    $('.thumbnail_box').live('mouseover', function(event) {      
        if( !$(this).hasClass("thumb_loaded")) {
            //this.style.backgroundImage="url(/thumbs/2010-10-27_Wayne_12-07-28_Session1_sprite.jpg)";
            var id = $(this).attr('data-interval');
            this.style.backgroundImage="url(/intervals/"+ id +".sprite)";
            $(this).addClass("thumb_loaded");
            
            // TODO: Make this "delay mask" less sketchy!
            // MASKING SPRITE LOAD DELAY
            var target = this;
            setTimeout( function(){ $(target).children("img").hide(); } , 100);
            //$(this).children("img").hide();
        }
    });
    
    // TODO: Make this "delay mask" less sketchy!
    // immediately invoke thumbnails after page load
    $(document).ready(function(){$('.thumbnail_box').trigger('mouseover')});
    
/* end Thumbnail fast scrub */    


$(document).ready(function(){
	
	// --------------------------------
	// .define_me
	// --------------------------------
	var hoverstatus = [];
	var offX = 4;
	var offY = 0;
	var zindex_inc = 1000;
	var delay = 200;
	var timeoutdelay = 20*1000;
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
			$(this).stopTime(name+"_timeout");
			$(this).oneTime(timeoutdelay, name+"_timeout", function(){
				hoverstatus[name] = 0;
				$("#definition_"+name.replace(" ", "_")).trigger("goaway");
			});
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



// -------------------------------------------------------------------
// Javascript for tagging
// -------------------------------------------------------------------
  jQuery(document).ready(function(){
    //$("#tag_container").delegate(".tag", "click", function(){
      //alert("I was clicked");
    //});

    $("#people_container, #phenomenon_container").delegate(".code", "click", function(){
      var name = $(this).text().trim();
      var coding_type = $(this).attr("data-codingType");
      $.ajax({
        url: document.URL + "/codings.json",
        type: 'POST',
        dateType: 'JSON',
        data: {"coding": {"name":name, "coding_type":coding_type}},
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
        },
        failure:function(){
          $("#tag_container").prepend('<div class="flash alert"> Your Tag could not be submitted at this time </div>');
        },
        success: function(data, status, xhr){
          console.log(data);
          console.log(status);
          console.log(xhr);
          var new_phenomenon = $.parseJSON(xhr.responseText);
          console.log(new_phenomenon);

          //change the color of the tag
          var query_string = '[data-rails_object_id = "' + new_phenomenon["codeID"] + '"]';
          console.log(query_string);
          var list_element = $('[data-rails_object_id="' + new_phenomenon["codeID"] + '"]');
          list_element.removeClass("unapplied").addClass("applied");

          //update the count
          var count = $("#" + new_phenomenon['codeType'] + "_count");
          count.text(parseInt(count.text()) + 1);

          //display a flash
          $('.flash').remove();
          $("#tag_container").prepend('<div class="flash notice"> Your Coding has been added </div>');

          //remove focus from the textboxes
          $('.coding_filter').blur();
        }
      });
    });

    $("#new_tag_form").bind("ajax:error", function(){
      $("#tag_container").prepend('<div class="flash alert"> Your Tag could not be submitted at this time </div>');  
    });

    $("#new_tag_form").bind("ajax:success", function(data, xhr, status){
      $(".flash").remove();
      $("#tag_container").prepend('<div class="flash notice"> Your Tag has been added </div>');  

      var newTagName = xhr["tagName"];
      console.log("tag successfully added" + newTagName);
    
      //append the new tag to the tag list
      $("#tag_list").append('<li class="tag applied">' + newTagName + '</li>');

      //update the tag count
      var current_value = $("#tag_count");
      console.log(current_value.text());
      current_value.text(parseInt(current_value.text()) + 1);
      
      //$("#tagging_name").trigger("blur");
      $("#tagging_name").attr("value", "");
    });

    $("#tagging_name").blur(function() {
      $(this).attr("value", "Enter New Tag");
    });

    $('#tagging_name').focus(function() {
      $(this).attr("value", "");
    });
    
  });



// ------------------------------------------------------------
// Javascript for client side filtering of phenomenon and people
//-------------------------------------------------------------
  var filterResults = function(value, elements){
    //var elements = $("#phenomenon_container ul li");
    for(var i = 0; i < elements.length; i ++){
      var element = $(elements[i]);
      var element_text = element.text();
      element_text = element_text.toLowerCase();
      if (element_text.indexOf(value.toLowerCase()) == -1){
        element.hide();
      }
      else{
        element.show();
      }
    }
  };

  jQuery(document).ready(function(){
    $('.coding_filter').keyup(function () {
      filterResults($(this).attr("value"), $(this).parent().find('ul li'));
    });
    //$('.coding_filter').parent(".interaction_container").blur(function() {
      //$(this).attr('value', '');
      //$(this).parent().find('ul li').show();
    //});      
    $('.coding_filter').parent(".interaction_container").blur(function() {
      $('.coding_filter').parent(".interaction_container").mouseleave(function  () {
        $(this).find(".coding_filter").attr("value", "");
        $(this).find("ul li").show();
      });
    });
  });  
