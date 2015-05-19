$(document).ready(function(){
  $( "#static_comment_button" ).click(function() {
    $("#static_comments").slideToggle( "slow" );
    if ($("#static_comments").is(':visible')) {
      $("html, body").animate({scrollTop: $("#static_comments").offset().top});
  }
  });
});