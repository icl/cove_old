$(document).ready(function(){
      
  var videoPlayer = VideoJS.setup('cove-video-player',{
//    offset: 30,
    controlsHiding: false
  });

  $("button.markstart").click(function(){
    videoPlayer.markSnippetStart();
    return false;
  });
  $("button.markend").click(function(){
    videoPlayer.markSnippetEnd();
    return false;
  });
 
  $('#new_snippet').submit(function(){
    $('#snippet_offset').val( videoPlayer.snippetStart() );
    $('#snippet_duration').val( videoPlayer.snippetDuration() );

    return true;
  });  
});

