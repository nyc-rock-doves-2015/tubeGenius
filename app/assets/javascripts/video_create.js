$(document).on("click", "#createNewVideo", function (event) {
  event.preventDefault();
  var $form = $("#new_video");
  $.ajax({
    url: "/videos",
    type: 'post',
    data: $form.serialize(),
    success: (function(){
      $form.submit();
    })
  })
})