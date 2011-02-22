/* Project Notes Functions */
$('.note_expandable').live('click', function(event) {
	$(event.target).parents('.project_note').children('.note_slide').slideToggle(200);
});
jQuery(function() {
	jQuery("#new_note").live('submit', function(event){
		$.ajax({
			type: 'POST',
			url: '/projects/' + $('.project_container').attr('id') + '/notes.js',
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
			},
			data: $(this).serialize()
		});
		return false;
	});
});
jQuery(function() {
	jQuery(".note_delete").live('click', function(event){
		$.ajax({
			type: 'DELETE',
			url: '/projects/' + $('.project_container').attr('id') + '/notes/' + $(event.target).attr('id'),
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
			},
			success: function() {
				$(event.target).parents('.project_note').remove();
			}
		});
		return false;
	});
});
/* Collection Prioritizing */
jQuery(function() {
	jQuery(".sortable_collection").sortable({
		distance: 40,
		update: function() {
			var i = 1;
			var priority = "priority={";
			$.each($(".sortable_collection li"),function() {
				$(this).find(".priority").text(i);
				i++;
				priority += "\'" + $(this).find(".priority").text() + "\': \'" + $(this).attr("id") + "\',";
			});
			priority += "}"
			$.ajax({
				type: 'POST',
				url: '/collections/' + $('.collection_container').attr('id') + '/prioritize',
				beforeSend: function(xhr) {
					xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
				},
				data: priority
			});
		}
	});
	jQuery(".sortable_collection").disableSelection();
});
jQuery(".priority_link").live('click', function(event) {
	var target = jQuery(event.target);
	var direction = target.attr("direction");
	var target_row = target.parents('li');
	var collection = target.parents('.collection_container').attr('id')

	if( !((target_row.attr('id') == $('.priority_link').first().parents('li').attr('id') && direction == "up") || (target_row.attr('id') == $('.priority_link').last().parents('li').attr('id') && direction == "down")) ) {

		$.ajax({
			type: 'POST',
			url: '/collections/' + collection + '/prioritize/' + target_row.attr('id') + '/' + direction,
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
			},
			success: function() {
				if (direction == "up") {

					var updata = target_row.prev('li');
					var up_priority = updata.find('.priority').text();
					var data = target_row;
					var priority = data.find('.priority').text();

					updata.replaceWith(data);
					data.after(updata);
					data.find('.priority').text(up_priority);
					updata.find('.priority').text(priority);

				} else if (direction == "down") {

					var downdata = target_row.next('li');
					var down_priority = downdata.find('.priority').text();
					var data = target_row;
					var priority = data.find('.priority').text();

					target_row.replaceWith(downdata);
					downdata.after(data);
					data.find('.priority').text(down_priority);
					downdata.find('.priority').text(priority);

				} else {
					// failure does nothing
				}			
			} 
		});
		
	};
	return false;
});
jQuery(function() {
	jQuery("a.remove_from_collection").click(function(event){
		$.ajax({
			type: 'DELETE',
			url: '/collections/' + $('.collection_container').attr('id') + '/remove/' + $(event.target).attr('id'),
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
			},
			success: function() {
				$(event.target).parents('.collection_cont').remove();
				var i = 1;
				var priority = "priority={";
				$.each($(".sortable_collection li"),function() {
					$(this).find(".priority").text(i);
					i++;
					priority += "\'" + $(this).find(".priority").text() + "\': \'" + $(this).attr("id") + "\',";
				});
			}
		});
		event.preventDefault();
		return false;
	});
});
/* Definition Function */
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
