var App = function() {};

App.getComments = function (video_id) {

  $.ajax({
    async: false,
    url: '/videos/' + video_id + '/json',
    type: 'get'
  }).done(function (response) {
    json_data = response
  });

  return json_data;
};

App.popcorn = function (video_url, video_container, comment_array) {
  var vid_setup = Popcorn.HTMLYouTubeVideoElement(video_container);
  vid_setup.src = video_url + "&controls=2"
  this.video = Popcorn(vid_setup);
  this.comments = comment_array;
}

//App.popcorn.prototype.showComments = function () {}

$(function () {
  var video_id = parseInt(window.location.href.match(/\d+$/));
  var results = App.getComments(video_id)
  var video = new App.popcorn(results[0], "#video", results[1])
  console.log("loaded")
});