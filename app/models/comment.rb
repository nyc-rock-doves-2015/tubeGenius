class Comment < ActiveRecord::Base
  after_create :create_notification

  belongs_to :user
  belongs_to :video
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :notifications

  validates :content, presence: true

  before_save :format_media

  def editable_by?(user)
    user == self.user || user == self.video.user
  end

  def format_media
    if self.new_record?
      if self.media_type == "IMAGE"
        self.content = "<img src='#{self.content}' style='height:100px;width:100px;'></img>"
      elsif self.media_type == "VIDEO"
        youtube_id = self.content.split("=").last
        self.content = "<iframe src='//www.youtube.com/embed/#{youtube_id}'></iframe>"
      end
    end
  end

private

  def create_notification
    if self.commentable_type == "Video"
    @video = Video.find_by(id: self.commentable_id)
    @user = User.find_by(id: @video.user_id)
      Notification.create(
       commentable_id: self.commentable.id,
       commentable_type: "Video",
       user_id: @user.id,
       comment_id: self.id,
       read: false
      )
    end
  end

end



