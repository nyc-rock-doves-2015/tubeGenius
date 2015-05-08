var App = {};

App.getComments = function (video_id) {

  $.ajax({
    async: false,
    url: '/videos/' + video_id + '/json',
    type: 'get'
  }).done(function (response) {
    json_data = response
  })

  return json_data;
};

$(function () {
  var video_id = parseInt(window.location.href.match(/\d+$/));
  var results = App.getComments(video_id)
  console.log(results)
})