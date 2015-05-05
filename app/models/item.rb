class Item < ActiveRecord::Base
  belongs_to :paper
  accepts_nested_attributes_for :paper
  validates_presence_of :name
end
