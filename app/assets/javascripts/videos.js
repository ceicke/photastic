jQuery(function() {
  // this is for the overview of the video thumbnail that shows and hides the control area
  $(".picture .picture_inner").find(".control_area").hide();
  $(".picture .picture_inner").hover(
    function(){
      $(this).find(".control_area").fadeIn(100);
    },function(){
      $(this).find(".control_area").fadeOut(200);
    }
  );
  
  $("a.inline").fancybox({
    'speedIn'   : 600, 
    'speedOut'    : 200, 
    'hideOnContentClick': false
  });

});