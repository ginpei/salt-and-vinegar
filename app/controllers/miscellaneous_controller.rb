class MiscellaneousController < ApplicationController
  def home
  end

  def example
    @paper = Paper.find_by_token('example')
    @item = @paper.items.new
    @items = @paper.items.all
    render template: 'papers/show'
  end
end
