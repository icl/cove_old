VideoJS.DOMReady(function(){
      
  var myPlayer = VideoJS.setup('cove-video-player',{
//    offset: 30,
    controlsHiding: false
  });

  $("button.markstart").click(function(){
    myPlayer.markSnippetStart();
    $('#snippet_offset').value = myPlayer.snippetStart();
  });
  $("button.markend").click(function(){
    myPlayer.markSnippetEnd();
    $('#snippet_duration').value = myPlayer.snippetDuration();
  });
 
  $('#new_snippet').submit(function(){
    $('#snippet_offset').value = myPlayer.snippetStart();
    $('#snippet_duration').value = myPlayer.snippetDuration();
  });  
});

