class Paper < ActiveRecord::Base
  belongs_to :book
  has_many :items
  accepts_nested_attributes_for :items
  validates :title, :presence => true
end
