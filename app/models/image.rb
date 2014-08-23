# == Schema Information
#
# Table name: images
#
#  id                 :uuid             not null, primary key
#  owner_id           :uuid
#  imageable_id       :uuid
#  imageable_type     :string(255)
#  caption            :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_fingerprint  :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  deleted_at         :datetime
#
# Indexes
#
#  index_images_on_imageable_id_and_imageable_type  (imageable_id,imageable_type)
#  index_images_on_owner_id                         (owner_id)
#

class Image < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :imageable, polymorphic: true
  belongs_to :owner, class: User, foreign_key: :owner_id,inverse_of: :owned_images

  validates :owner, presence: true

  has_attached_file(:image, 
                    styles: {tiny: "32x32>", thumbnail: "170x170>"},
                    convert_options: {tiny: "-quality 75", thumbnail: "-quality 85"},
                    preserve_files: true,
                    default_url: "/assets/:style/default_profile_pic.png",
                   )

  validates_attachment :image, 
    presence: true,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    size: { in: 0..10.megabytes }
end
