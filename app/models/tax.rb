class Tax < ActiveRecord::Base
  belongs_to :book
  has_and_belongs_to_many :items
end
