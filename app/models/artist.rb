class Artist < ActiveRecord::Base
  validates :name, presence: true
  validates :artsy_id, :slug, presence: true, uniqueness: true
end
