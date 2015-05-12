class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :video
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

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

end
