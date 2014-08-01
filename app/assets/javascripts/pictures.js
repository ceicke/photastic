jQuery(function() {
  // this is for the overview of the pictures that shows and hides the control area
  $(".picture_thumb .picture_inner").find(".control_area").hide();
  $(".picture_thumb .picture_inner").hover(
    function(){
      $(this).find(".control_area").fadeIn(100);
    },function(){
      $(this).find(".control_area").fadeOut(200);
    }
  );
  // this is for displaying the fancybox for the images
  $("a.fancyboxgroup").fancybox({
    'transitionIn'  : 'fade',
    'transitionOut' : 'fade',
    'speedIn'   : 600, 
    'speedOut'    : 200, 
    'overlayShow' : false
  });

  $('.dropdown-toggle').dropdown();

  $wrapper = $('#wrapper').isotope({
    itemSelector: '.picture_thumb',
    layoutMode: 'masonry',
    masonry : {
      columnWidth: 300
    }
  });

});
