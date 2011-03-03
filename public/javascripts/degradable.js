/* Project Notes Functions */
$('.note_expandable').live('click', function(event) {
	var fadeTarget = $(event.target).parents('.note_header').children('.note_slide');
	fadeTarget.fadeToggle(0, function () {
		if (fadeTarget.css('display') != 'none') {
			fadeTarget.css('display','inline')
		}
	});
	var brs = $(event.target).parents('.note_header').children('.note_expandable').children('.note_br');
	if (brs.first().css('display') == 'none') {
		brs.css('display','inline');
	} else {
		brs.css('display','none');
	}
	var collapsable = $(event.target).parents('.note_header').children('.collapsable');
	collapsable.fadeToggle(0, function () {
		if (collapsable.css('display') != 'none') {
			collapsable.css('display','inline')
		}
	});
	var expandable = $(event.target).parents('.note_header').children('.expandable');
	expandable.fadeToggle(0, function () {
		if (expandable.css('display') != 'none') {
			expandable.css('display','inline')
		}
	});
});
$('.expand_all').live('click', function(event) {
	$(event.target).parents('.note_list_container').children('.note_list').children('li').children('.note_header').children('.first.note_expandable').click();
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
	jQuery(".note_delete").click(function(event){
		event.preventDefault();
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
				priority += "\'" + i + "\': \'" + $(this).attr("id") + "\',";
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
/* Infinite Carousel Code by Remy Sharp http://jqueryfordesigners.com */
$.fn.infiniteCarousel = function () {

    function repeat(str, num) {
        return new Array( num + 1 ).join( str );
    }
  
    return this.each(function () {
        var $wrapper = $('> div', this).css('overflow', 'hidden'),
            $slider = $wrapper.find('> ul'),
            $items = $slider.find('> li'),
            $single = $items.filter(':first'),
            
            singleWidth = $single.outerWidth(), 
            visible = Math.ceil($wrapper.innerWidth() / singleWidth), // note: doesn't include padding or border
            currentPage = 1,
            pages = Math.ceil($items.length / visible);            


        // 1. Pad so that 'visible' number will always be seen, otherwise create empty items
        if (($items.length % visible) != 0) {
            $slider.append(repeat('<li class="empty" />', visible - ($items.length % visible)));
            $items = $slider.find('> li');
        }

        // 2. Top and tail the list with 'visible' number of items, top has the last section, and tail has the first
        $items.filter(':first').before($items.slice(- visible).clone().addClass('cloned'));
        $items.filter(':last').after($items.slice(0, visible).clone().addClass('cloned'));
        $items = $slider.find('> li'); // reselect
        
        // 3. Set the left position to the first 'real' item
        $wrapper.scrollLeft(singleWidth * visible);
        
        // 4. paging function
        function gotoPage(page) {
            var dir = page < currentPage ? -1 : 1,
                n = Math.abs(currentPage - page),
                left = singleWidth * dir * visible * n;
            
            $wrapper.filter(':not(:animated)').animate({
                scrollLeft : '+=' + left
            }, 500, function () {
                if (page == 0) {
                    $wrapper.scrollLeft(singleWidth * visible * pages);
                    page = pages;
                } else if (page > pages) {
                    $wrapper.scrollLeft(singleWidth * visible);
                    // reset back to start position
                    page = 1;
                } 

                currentPage = page;
            });                
            
            return false;
        }
        
        $(this, '.wrapper').prepend('<a class="arrow_backward">&nbsp;</a>');
		$(this, '.wrapper').append('<a class="arrow_forward">&nbsp;</a>');
        
        // 5. Bind to the forward and back buttons
        $('a.arrow_backward', this).click(function () {
            return gotoPage(currentPage - 1);                
        });
        
        $('a.arrow_forward', this).click(function () {
            return gotoPage(currentPage + 1);
        });
        
        // create a public interface to move to a specific page
        $(this).bind('goto', function (event, page) {
            gotoPage(page);
        });
    });  
};

$(document).ready(function () {
  $('.infiniteCarousel').infiniteCarousel();
});