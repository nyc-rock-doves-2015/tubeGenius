class Comment < ActiveRecord::Base
  after_create :create_notification

  belongs_to :user
  belongs_to :video
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :notifications

  validates :content, presence: true

  before_save :format_media, :check_times

  def editable_by?(user)
    user == self.user || user == self.video.user
  end

  def check_times
    if self.new_record?
      if self.start_time == "" || self.start_time.to_i < 0
        self.start_time = "0"
      elsif self.end_time == "" || self.end_time.to_i < 0
        self.end_time = "0"
      end
    end
  end

  def format_media
    if self.new_record?
      if self.media_type == "IMAGE"
        self.content = "<img src='#{self.content}' class='comment-image'></img>"
      elsif self.media_type == "VIDEO"
        youtube_id = self.content.split("=").last
        self.content = "<iframe src='//www.youtube.com/embed/#{youtube_id}'></iframe>"
      end
    end
  end

  def find_video_parent
    return self.commentable if self.commentable_type == "Video"
    self.commentable.find_video_parent
  end

  def self.format_times(seconds)
    seconds = seconds.to_i
    min = (seconds / 60).floor.to_s
    if seconds % 60 == 0
      sec = "00"
    elsif seconds % 60 < 10
      sec = "0" + (seconds % 60).to_s
    else
      sec = (seconds % 60).to_s
    end
    min + ":" + sec
  end

private

  def create_notification
    @parent = self.commentable
    @user = User.find_by(id: @parent.user_id)
      Notification.create(
       commentable_id: self.commentable.id,
       commentable_type: self.commentable_type,
       user_id: @user.id,
       comment_id: self.id,
       read: false
      )
  end

end



