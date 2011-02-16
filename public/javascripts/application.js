VideoJS.DOMReady(function(){
      
  var myPlayer = VideoJS.setup('cove-video-player',{
//    offset: 30,
    controlsHiding: false
  });

  $("button.markstart").click(function(){
    myPlayer.markSnippetStart();
    return false;
  });
  $("button.markend").click(function(){
    myPlayer.markSnippetEnd();
    return false;
  });
 
  $('#new_snippet').submit(function(){
    $('#snippet_offset').val( myPlayer.snippetStart() );
    $('#snippet_duration').val( myPlayer.snippetDuration() );

    return true;
  });  
});

