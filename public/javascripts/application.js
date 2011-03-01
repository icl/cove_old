    function swapThumb(obj)
    {
        num=obj.id;
        name=obj.title;
        //alert("in swapThumb");
        // Improvements to remove flickering issue
        // 1) pre-buffer images and only show them when fetch is complete
        // 2) fetch a sprite (ruby sprite gem or imagicmagik)
        //alert("in swapThumb method")
        document.getElementById("thumb_"+name).innerHTML='<img src ="/thumbs/'+num+'.jpg" width ="160" height ="90" usemap="#thumbmap_'+name+'" />';
    }
    
    //document.getElementById("thumb_"+name).addEventListener('onmouseover',swapThumb, false) {}
    //$('.thumb_scrub').live('mouseover', function(event) {
       //alert("in bind fuction")
       //swapThumb(this); 
    //});
    
    function changeSpriteWindow(obj){
        // DEBUG //console.warn($(obj).position().left);
        //TODO: figure out how to grab misc 10 pixel additional margin
        var extra_margin =10;
        var newY = (event.clientX-($(obj).position().left)-extra_margin)*90;
        var position = "0px " + newY + "px "
        // DEBUG //console.warn(position);
        obj.style.backgroundPosition = position;
    }
    
    $('.thumbnail_box').live('mousemove', function(event) {
        //console.warn(event.clientX);
        changeSpriteWindow(this);
    });
    
    $('.thumbnail_box').live('mouseover', function(event) {        
        if( !$(this).hasClass("thumb_loaded")) {
            this.style.backgroundImage="url(/thumbs/2010-10-27_Wayne_12-07-28_Session1_sprite.jpg)";
            $(this).addClass("thumb_loaded");
        }
        //console.warn("entering thumbnail box handler");
        $(this).children("img").hide();
    });