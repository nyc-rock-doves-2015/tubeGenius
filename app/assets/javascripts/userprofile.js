$(function () {
  $(document).on("click", "#message-button", function (event) {
    var $target = $(event.target)
    $.ajax({
      url: $target.attr("href"),
      type: 'get'
    }).done(function (response) {
      $('#sendmessage-modal').html(response);
    })
  })
})