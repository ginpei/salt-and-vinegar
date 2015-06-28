class Book < ActiveRecord::Base
  has_many :papers
  before_create :add_token

  validates :name, :presence => true

  def to_param
    token
  end

  def add_token
    self.token = SecureRandom.uuid
  end
end
