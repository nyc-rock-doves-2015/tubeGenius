var App = function() {};

App.getComments = function (video_id) {
  var json_data;
  $.ajax({
    async: false,
    url: '/videos/' + video_id + '/json',
    type: 'get'
  }).done(function (response) {
    json_data = response
  });

  return json_data;
};

App.Popcorn = function (video_url, video_container, comment_array) {
  var vid_setup = Popcorn.HTMLYouTubeVideoElement(video_container);
  vid_setup.src = video_url + "&controls=2"
  this.video = Popcorn(vid_setup);
  this.comments = comment_array;
}

App.Popcorn.prototype.showComments = function () {
  for(x=0; x<this.comments.length; x++){
    this.video.footnote({
      start: this.comments[x].start_time,
      end: this.comments[x].end_time,
      text: this.comments[x].content,
      target: "comments_container"
    });
  }
}

$(function () {
  var video_id = parseInt(window.location.href.match(/\d+$/));
  var results = App.getComments(video_id)
  var video = new App.Popcorn(results[0], "#video", results[1])
  video.showComments();
});
