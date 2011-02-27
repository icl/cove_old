$(document).ready(function(){
      
  
  var videoPlayer = VideoJS.setup('cove-video-player',{
//    offset: 30,
    controlsHiding: false,
    controlsAtStart: true,
    controlsBelow: true
  });

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
  
  $('.interval_form').hide();
  $('.create_interval_button').click(function(){
    $('.interval_form').show("slide", {direction: "left"}, 1000);
    return false;
  });
  
  $('button.cancel').click(function(){
    $('.interval_form').hide("slide", {direction: "left"}, 1000);
    $('.create_interval_button').show();
    return false;
  });
  
   $('button.save').click(function(){
    $('.interval_form').hide("slide", {direction: "left"}, 1000);
    $('.create_interval_button').show();
    return false;
  });
  
  $('.snippet').click(function(){
    $('.interval_form').hide();
    return false;
  });
    
 
  $("#new_snippet").submit(function(event){
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


