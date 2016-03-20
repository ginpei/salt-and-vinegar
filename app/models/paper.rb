class Paper < ActiveRecord::Base
  belongs_to :book
  has_many :items
  accepts_nested_attributes_for :items

  def set_todays_date
    self.title = Time.now.strftime('%Y-%m-%d')
  end

  # copy items from another papers
  def copy_items_from(paper, ids)
    if ids
      ids.each do |item_id|
        item = paper.items.find(item_id)
        if item
          items.new(
            name: item.name,
            quantity: item.quantity,
            orderer: item.orderer,
          )
        end
      end
    end
  end
end
