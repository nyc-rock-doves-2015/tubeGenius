$(function () {
  $(document).on("click", "#message-button", function (event) {
    var $target = $(event.target);
    $.ajax({
      url: $target.attr("href"),
      type: 'get'
    }).done(function (response) {
      $('#sendmessage-modal').html(response);
    });
  });

  $(document).on("submit", "#message-form", function (event) {
    event.preventDefault();
    $target = $(event.target);
    $.ajax({
      url: $target.attr("action"),
      type: 'post',
      data: $target.serialize()
    }).done(function () {
      $('#sendmessage-modal').foundation('reveal', 'close');
      video.video.play();
    }).fail(function () {
      $('#sendmessage-modal').foundation('reveal', 'close');
      video.video.play();
    });
  });
});