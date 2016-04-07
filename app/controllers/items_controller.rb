class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.save
    render_item_json @item

    session[:orderer] = @item.orderer
  end

  # POST /items/multi
  def create_multi
    item_params = params.permit(:paper_id, :name_list, :orderer)
    unless item_params[:name_list].present?
      messages = ['At least one item is required.']
      render status: 400, json: { status: 'error', messages: messages }
      return
    end

    items = []
    Item.split_multi_params(item_params).each do |attr|
      item = Item.new(attr)
      item.save()
      items.push(item)
    end

    html = make_html_for_new_items(items)
    render json: { status: 'success', items: items, html: html }
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @book = @item.paper.book
    @item.update_with_tax_ids(item_params)
    render_item_json @item
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    render json: { status: 'success' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:paper_id, :name, :quantity, :orderer, :price, :unit, :comment, tax_ids:[])
    end

    def render_item_json item
      if item.errors.empty?
        html = render_to_string('items/_show', layout: nil, locals: { item: @item } )
        render json: { status: 'success', item: item, html: html }
      else
        messages = item.errors.full_messages
        render status: 400, json: { status: 'error', messages: messages }
      end
    end

    def make_html_for_new_items items
      html = items
        .map {|item| render_to_string('items/_show', layout: nil, locals: { item: item }) }
        .join('')
      end
end
