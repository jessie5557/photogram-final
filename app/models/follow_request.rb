# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipeint_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
end
