class Artist < ActiveRecord::Base
  validates :name, presence: true
  validates :artsy_id, :slug, presence: true, uniqueness: true

  def calculate_score!
    self.score = page_views + follows
    save!
  end
end
