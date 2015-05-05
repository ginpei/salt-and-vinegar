class Paper < ActiveRecord::Base
  has_many :items
  accepts_nested_attributes_for :items
  validates :title, :presence => true
end
