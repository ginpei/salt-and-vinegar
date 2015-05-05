class Paper < ActiveRecord::Base
  validates :title, :presence => true
end
