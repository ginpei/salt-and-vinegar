class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.save
    render_item_json @item
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:item).permit(:paper_id, :name, :quantity, :orderer)
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
end
