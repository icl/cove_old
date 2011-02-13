VideoJS.DOMReady(function(){
      
  var myPlayer = VideoJS.setup('cove-video-player',{
    controlsHiding: false
  });

  $("button.markstart").click(function(){ myPlayer.markSnippetStart(); });
  $("button.markend").click(function(){ myPlayer.markSnippetEnd(); });

  
});

