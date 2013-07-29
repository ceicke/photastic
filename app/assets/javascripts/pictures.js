jQuery(function() {
  // this is for displaying the fancybox
  $("a.fancyboxgroup").fancybox({
    'transitionIn'  : 'fade',
    'transitionOut' : 'fade',
    'speedIn'   : 600, 
    'speedOut'    : 200, 
    'overlayShow' : false
  });

  $('.pictures').imagesLoaded(function() {

    var $container = $('.pictures');
    // initialize
    $container.masonry({
      columnWidth: 100,
      itemSelector: '.picture',
      gutter: 10,
      isFitWidth: true,
    });

  });   

  $("img").lazyload({
    effect: "fadeIn"
  }); 
});