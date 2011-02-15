jQuery(function() {
	jQuery(".sortable_collection").sortable({
		delay: 500,
		stop: function() {
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

	if( !((target_row.attr('id') == '1' && direction == "up") || (target_row.attr('id') == $('.priority_link').last().parents('li').attr('id') && direction == "down")) ) {

		$.ajax({
			type: 'POST',
			url: '/collections/' + collection + '/prioritize/' + target_row.attr('id') + '/' + direction,
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
			},
			success: function() {
				if (direction == "up") {

					var updata = target_row.prev('li');
					var data = target_row;

					updata.replaceWith(data);
					data.after(updata);

				} else if (direction == "down") {

					var downdata = target_row.next('li');
					var data = target_row;

					target_row.replaceWith(downdata);
					downdata.after(data);

				} else {
					// failure does nothing
				}			
			} 
		});
		
	};
	return false;
});