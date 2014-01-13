class Photo < ActiveRecord::Base

  belongs_to :photographable, polymorphic: true

  validates :filename, presence: true
  validates :file_type, presence: true

end
