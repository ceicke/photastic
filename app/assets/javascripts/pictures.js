jQuery(function() {

  var $container = $('.pictures');
  $container.masonry({
    columnWidth: 100,
    itemSelector: '.picture',
    gutter: 10,
    isFitWidth: true,
  });

  $("img").lazyload({
    effect: "fadeIn"
  }); 

  $('a.colorbox').colorbox()
});