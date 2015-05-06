class Paper < ActiveRecord::Base
  has_many :items
  accepts_nested_attributes_for :items
  validates :title, :presence => true
  before_create :add_token

  def to_param
    token
  end

  def add_token
    self.token = SecureRandom.uuid
  end
end
