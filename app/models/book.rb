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

  def recent_papers
    limit = 5
    papers.order('created_at DESC').limit(limit+1).slice(1, limit)
  end

  # Create a new paper with items copied from last paper
  def turn_over(attr, item_ids)
    paper = papers.new(attr)
    paper.copy_items_from(current_paper, item_ids)
    paper
  end

  def copy_recent_items(data)
    current_paper = self.current_paper

    data.each do |paper_id, item_ids|
      old_paper = papers.find(paper_id)
      current_paper.copy_items_from(old_paper, item_ids) if old_paper
    end

    current_paper
  end
end
