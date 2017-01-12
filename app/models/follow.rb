class Follow < ApplicationRecord
  belongs_to :follower, polymorphic: true
  belongs_to :followed, polymorphic: true
end
