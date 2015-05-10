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

App.initNewComment = function (popcorn_instance) {
  $('#comment_button').on("click", function (event) {
    $('.new_comment')[0][3].value = Math.floor(popcorn_instance.video.currentTime());
    var end_time = setInterval(function () {
        $('.new_comment')[0][4].value = Math.floor(popcorn_instance.video.currentTime() + 5);
      }, 100);

    $('#comment_end_time').on("focus", function () {
      clearInterval(end_time);
    })
  });
}

App.formatSeconds = function (seconds) {
  var min = (Math.floor(seconds/60)).toString();
  var sec; 
  if(seconds % 60 == 0) {
    sec = "00";
  } else if ((seconds % 60) < 10) {
    sec = "0" + (seconds % 60).toString();
  } else {
    sec = (seconds%60).toString();
  }
  return min + ":" + sec
}

App.formatComment = function (start, end, content) {
  var start = App.formatSeconds(start);
  var end = App.formatSeconds(end);
  return "@" + start + "-" + end + "</a>" + "<br>" + content
}

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
      text: App.formatComment(this.comments[x].start_time, this.comments[x].end_time, this.comments[x].content),
      target: "com"
    });
  }
}

App.Popcorn.prototype.updateTime = function () {
  $('#timeclick').on("click", function (event) {
    event.preventDefault();
    event.stopPropagation();
    console.log("test");
  })
}

App.Popcorn.prototype.addComment = function () {
  var self = this;
  $('.new_comment').on("submit", function (event) {
    event.preventDefault();

    $('#comment-modal').foundation('reveal', 'close');
    
    var $target = $(event.target);
    var $text = $target[0][2];
    var $start = $target[0][3];
    var $end = $target[0][4];

    $.ajax({
      url: $target.attr("action"),
      type: 'post',
      data: $target.serialize()
    }).done(function (response) {
      self.video.footnote({start: parseInt($start.value), end: parseInt($end.value), text: $text.value, target: "com"});
      $start.value = ""; 
      $end.value = ""; 
      $text.value = "";
    })
  })
}

$(function () {
  var video_id = parseInt(window.location.href.match(/\d+$/));
  var results = App.getComments(video_id);
  var video = new App.Popcorn(results[0], "#video", results[1]);
  App.initNewComment(video);

  video.showComments();
  video.addComment();
  video.updateTime();
});
