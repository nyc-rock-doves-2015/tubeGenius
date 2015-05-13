$(document).ready(function() {

  $('.form-signin').on("submit", function (event) {
    event.preventDefault();
    $target = $(event.target);
    
    $.ajax({
      url: $target.attr("action"),
      type: 'POST',
      data: $target.serialize()
    }).done(function (response) {
      // console.log(response)
      if ($(response).filter('.flash')){
        console.log(response)

        $('#signin-modal').foundation('reveal', 'open');
      }else{
        console.log("heya")
        console.log(response);
      }
    })
  })
})
