var App = {};

App.getComments = function (video_id) {
  var json_data;
  $.ajax({
    async: false,
    url: '/videos/' + video_id + '.json',
    type: 'get'
  }).done(function (response) {
    json_data = response;
  });
  return json_data;
};

App.initNewComment = function (popcorn_instance) {
  $('#comment_button').on("click", function (event) {
    video.video.pause();
    
    $('.new_comment')[0][3].value = Math.floor(popcorn_instance.video.currentTime());
    var end_time = setInterval(function () {
      $('.new_comment')[0][4].value = Math.floor(popcorn_instance.video.currentTime() + 5);
    }, 100);

    $('#comment_end_time').on("focus", function () {
      clearInterval(end_time);
    });
  });
};

App.formatSeconds = function (seconds) {
  var min = (Math.floor(seconds/60)).toString();
  var sec;
  if(seconds % 60 === 0) {
    sec = "00";
  } else if ((seconds % 60) < 10) {
    sec = "0" + (seconds % 60).toString();
  } else {
    sec = (seconds%60).toString();
  }
  return min + ":" + sec;
};

App.formatMediaContent = function (content, type) {
  var formatted_content;
  if (type === "image") {
    formatted_content = "<img src=" + content + " class='comment-image'></img>";
  } else if (type === "video") {
    youtube_id = content.split("=")[1];
    formatted_content = "<iframe src='//www.youtube.com/embed/" + youtube_id + "'></iframe>";
  } else {
    formatted_content = content;
  }
  return formatted_content;
};

App.formatGravatar = function (user) {
  return "<a id='user-profile-link' data-reveal-id='user-modal' href='/users/" + user.id.toString() + "'>" + "<img src='" + user.gravatar_url + "' height='30' width='30' >" + "</a>";
};

App.formatComment = function (start, end, content, user, media_type) {
  var formatted_content = App.formatMediaContent(content, media_type);
  var start = App.formatSeconds(start);
  var end = App.formatSeconds(end);
  var gravatar = App.formatGravatar(user);
  return  gravatar + " @" +start + "-" + end + "<br>" + "<br>" + "<p>" + formatted_content + "</p>";
};

App.Popcorn = function (video_url, video_container, comment_array) {
  var vid_setup = Popcorn.HTMLYouTubeVideoElement(video_container);
  vid_setup.src = video_url + "&controls=2"
  this.video = Popcorn(vid_setup);
  this.comments = comment_array;
};

App.Popcorn.prototype.showComments = function () {
  for(x=0; x<this.comments.length; x++){
    this.video.footnote({
      start: this.comments[x].start_time,
      end: this.comments[x].end_time,
      text: App.formatComment(
        this.comments[x].start_time,
        this.comments[x].end_time,
        this.comments[x].content,
        this.comments[x].user),
      target: "com"
    });
  }
};

App.Popcorn.prototype.addComment = function () {
  var self = this;
  var new_comment;
  $('.new_comment').on("submit", function (event) {
    event.preventDefault();

    $('#comment-modal').foundation('reveal', 'close');

    var $target = $(event.target);
    var $text = $target[0][2];
    var $start = $target[0][3];
    var $end = $target[0][4];
    var media_type;

    if ($start.value === "" || $start.value < 0) {
      $start.value = 0;
    } else if ($end.value === "" || $end.value < 0) {
      $end.value = 0;
    }

    if ($target[0][5].checked === true) {
      media_type = "text";
    } else if ($target[0][6].checked === true) {
      media_type = "video";
    } else if ($target[0][7].checked === true) {
      media_type = "image";
    }

    $.ajax({
      url: $target.attr("action"),
      type: 'post',
      data: $target.serialize()
    }).done(function (response) {
      self.video.footnote({
        start: response.start_time,
        end: response.end_time,
        text: App.formatComment(parseInt(response.start_time), parseInt(response.end_time), $text.value, response.user, media_type),
        target: "com"});
      $start.value = "";
      $end.value = "";
      $text.value = "";
      video.video.play();
    });
  });
};

App.init = function () {
  $(function () {
    var video_id = parseInt(window.location.href.match(/\d+\/*$/));
    var results = App.getComments(video_id);
    video = new App.Popcorn(results[0], "#video", results[1]);

    App.initNewComment(video);
    video.showComments();
    video.addComment();

    $(document).on("click", ".comment", function (event) {
      video.video.pause();
    });

    $(document).on("click", "#user-profile-link", function (event) {
      video.video.pause();
      event.preventDefault();
      event.stopPropagation();

      var $target = $(event.target);

      $.ajax({
        url: $target.parent().attr("href"),
        type: 'get'
      }).done(function (response) {
        $('#user-modal').html(response);
      });

      $(document).on('close.fndtn.reveal', '#user-modal', function () {
        var modal = $(this);
        video.video.play();
      });
    });
  });
};