class Post < ApplicationRecord
  validates_presence_of :title, :description
  validates_length_of :title, within: 1..200, too_long: 'pick a shorter title', too_short: 'pick a longer title'

  belongs_to :city, optional: true
  belongs_to :user, optional: true

end
