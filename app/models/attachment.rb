class Attachment < ActiveRecord::Base
  
  validates :attachable_id, presence: true
  validates :attachable_type, presence: true
  
  belongs_to :attachable, polymorphic: true
  
  # from paperclip
  has_attached_file :asset, styles: {thumb: "60x50#", square: "100x100#", main: "600x400>"}

  validates_attachment :asset, :presence => true,
    :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png", "application/pdf"] },
    :size => {:in => 0..300.kilobytes}
  
  
  before_post_process :is_photo?
   
  
  def is_photo?
    %w(image/jpeg image/jpg image/gif image/png).include?(asset_content_type)
  end
    
end
