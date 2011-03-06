$(document).ready(function(){

  var videoPlayer = $('#cove-video-player').VideoJS({
    offset: 30,
    controlsHiding: false,
    controlsAtStart: true
  }).player(); 

  function secondsToString(secs) {
    var deciseconds = Math.round(secs * 100);
    var seconds = Math.floor(deciseconds / 100);
    var minutes = Math.floor(seconds / 60);
    minutes = (minutes >= 10) ? minutes : "0" + minutes;
    seconds = Math.floor(seconds % 60);
    seconds = (seconds >= 10) ? seconds : "0" + seconds;
    deciseconds = Math.floor(deciseconds % 100);
    deciseconds = (deciseconds >= 10) ? deciseconds : "0" + deciseconds;
    return minutes + ":" + seconds + "." + deciseconds;
  }

  function stringToSeconds(str) {
    var nums = str.split(":");
    if (nums.length == 1) return parseFloat( nums[0] );
    else if (nums.length == 2) return parseInt( nums[0] ) * 60 + parseFloat( nums[1] );
    else return NaN;
  }

  $("button.markstart").click(function(){
    videoPlayer.markSnippetStart();
    $("#start_mark").val( secondsToString(videoPlayer.snippetStart()) );
    return false;
  });
  
  $("button.markend").click(function(){
    videoPlayer.markSnippetEnd();
    $("#end_mark").val( secondsToString(videoPlayer.snippetEnd()) );
    return false;
  });
  
  $("#start_mark").change(function(){
    videoPlayer.snippetStart( stringToSeconds(this.value) );
    $(this).val( secondsToString( videoPlayer.snippetStart() ));
    return false;
  });

  $("#end_mark").change(function(){
    videoPlayer.snippetEnd( stringToSeconds(this.value) );
    $(this).val( secondsToString( videoPlayer.snippetEnd() ));
    return false;
  }); 
  
  /* Billy's javascript */
  
  $('.snippet_info').hide();
  $('.interval_form').hide();
  $('.mark_buttons').hide();
  
  $('.create_interval_button').click(function(){
    $('.create_interval_button').hide();
    $('.mark_buttons').show("slide", {direction: "left"}, 2000);
    $('.interval_form').show("slide", {direction: "left"}, 2050);
    $('.snippet_info').hide();
    return false;
  });
  
  $('button.cancel').click(function(){
    $('.interval_form').hide("slide", {direction: "left"}, 500);
    $('.mark_buttons').hide("slide", {direction: "left"}, 500);
    $('.create_interval_button').show();
    return false;
  });
  
  $('.snippet_edit').hide();
  
  $('.snippet').click(function(){
    $('.interval_form').hide();
    $('.snippet_info').show();
    $('.create_interval_button').show();
    $('.interval_browse').show();
    $('.mark_buttons').hide("slide", {direction: "left"}, 500);
    return false;
  });
  
  $('button.delete').click(function(){
    $('.snippet_info').hide();
    $('.create_interval_button').show();
    return false;
  });
  
  /* End Billy's js */
    
 
  $("#new_snippet_form").submit(function(event){
    $('#snippet_offset').val( videoPlayer.snippetStart() );
    $('#snippet_duration').val( videoPlayer.snippetDuration() );

    var target = $(event.target);

    // This part borrowed from Paul
    $.ajax({
      type: 'POST' ,
      url: target.attr( 'action' ),
      data: target.serialize(),
      beforeSend: function(xhr) {
        xhr.setRequestHeader("Accept",'text/html');
      },
      success: function(data) {
        $('.interval_browse').html(data);
        setTimeout( function() { jQuery(".noticeSuccessful").fadeTo(1000,0); }, 6000);
        setTimeout( function() { jQuery(".noticeErrors").fadeTo(1000,0); }, 30000);
        clearTimeout();
        return false;
      },
      dataType: 'text'
    });
    return false;
  });
});

/* Thumbnail fast scrub */    
$(document).ready(function(){
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
    
});
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
          $("#tag_container").prepend('<div class="flash notice"> Your Coding has been added </div>');
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
    $('.coding_filter').blur(function() {
      $(this).attr('value', '');
      $(this).parent().find('ul li').show();
    });

  });  
