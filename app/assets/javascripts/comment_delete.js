$(document).ready(function(){
    $(".comment_deletion").on('click', function(event) {
      event.preventDefault();
      var commentContainer = $(this).parent();
      var deletePath = '/videos/' + commentContainer[0].id + '/comments/' + event.target.id

      $.ajax({
          url: deletePath,
          type: 'DELETE',
          success: function() {
            commentContainer.slideUp('fast', function() {$(this).remove();});
          }
      });
   });
});