$(function () {
  $("#message-button").on("click", function (event) {
    var $target = $(event.target)
    $.ajax({
      url: $target.attr("href"),
      type: 'get'
    }).done(function (response) {
      console.log(response)
      $('#sendmessage-modal').html(response);
    })
  })
})