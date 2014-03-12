jQuery(function() {
  // this is for the overview of the video thumbnail that shows and hides the control area
  $(".picture_thumb .picture_inner").find(".control_area").hide();
  $(".picture_thumb .picture_inner").hover(
    function(){
      $(this).find(".control_area").fadeIn(100);
    },function(){
      $(this).find(".control_area").fadeOut(200);
    }
  );

  $('#wrapper').isotope({
    itemSelector: '.picture_thumb',
    layoutMode: 'masonry',
    masonry : {
        columnWidth: 300
    }
  });

});