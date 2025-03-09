# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Like < ApplicationRecord
  belongs_to :liked_by, required: true, class_name: "User", foreign_key: "fan_id"
  belongs_to :photo_liked, required: true, class_name: "Photo", foreign_key: "photo_id"
end
