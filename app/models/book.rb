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

  def current_paper
    papers.order('created_at DESC').first
  end

  def last_paper
    papers.order('created_at DESC').at(1)
  end

  # Create a new paper with items copied from last paper
  def turn_over(attr, item_ids)
    last_paper = self.current_paper
    paper = papers.new(attr)
    item_ids.each do |item_id|
      last_item = last_paper.items.find(item_id)
      if last_item
        paper.items.new(
          name: last_item.name,
          quantity: last_item.quantity,
          orderer: last_item.orderer,
        )
      end
    end
    paper
  end
end
