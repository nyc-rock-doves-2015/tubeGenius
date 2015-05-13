$(function () {
  $('#inbox-link').on("click", function (event) {
      event.preventDefault();
      $.ajax({
        url: '/conversations?box=inbox',
        type: 'get'
      }).done(function (response) {
        $('#messages').html(response);
        $('#box-type').html("Inbox")
      });
    });

  $('#sent-link').on("click", function (event) {
    event.preventDefault();
    $.ajax({
      url: '/conversations?box=sent',
      type: 'get'
    }).done(function (response) {
      $('#messages').html(response);
      $('#box-type').html("Sent messages")
    });
  });

  $('#trash-link').on("click", function (event) {
    event.preventDefault();
    $.ajax({
      url: '/conversations?box=trash',
      type: 'get'
    }).done(function (response) {
      $('#messages').html(response);
      $('#box-type').html("Trash")
    });
  });
})  
  
