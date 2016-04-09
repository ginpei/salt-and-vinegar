class PapersController < ApplicationController
  before_action :set_book
  before_action :set_paper, only: [:show, :edit, :shopping, :purchase, :update, :save_purchase, :destroy]

  # GET /papers/1
  # GET /papers/1.json
  def show
    @title = @paper.title
    @papers = @book.papers.reverse

    @item = @paper.items.new
    @items = @paper.items.all
    @item.orderer = session[:orderer]
  end

  # GET /papers/new
  def new
    @title = 'Create New Paper'

    @last_paper = @book.current_paper
    @last_items = @last_paper.items

    @paper = @book.papers.new
    @paper.currency = @paper.default_currency
  end

  # GET /papers/1/edit
  def edit
    @title = "Edit - #{@paper.title}"
  end

  # GET /papers/1/shopping
  def shopping
    @title = @paper.title
    @papers = @book.papers.reverse

    @item = @paper.items.new
    @items = @paper.items.all
    @item.orderer = session[:orderer]
  end

  # GET /papers/1/purchase
  def purchase
    @title = @paper.title
    @papers = @book.papers.reverse
    @items = @paper.items.all
  end

  # POST /papers
  # POST /papers.json
  def create
    @last_paper = @book.current_paper
    @paper = @book.turn_over(paper_params, params[:last_item])

    respond_to do |format|
      if @paper.save
        unless @last_paper.title.present?
          @last_paper.set_todays_date
          @last_paper.save
        end

        format.html { redirect_to @book, notice: 'Paper was successfully created.' }
        format.json { render :show, status: :created, location: @paper }
      else
        format.html { render :new }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      if @paper.update(paper_params)
        if @paper == @book.current_paper
          url = @book
        else
          url = [@book, @paper]
        end
        format.html { redirect_to url, notice: 'Paper was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper }
      else
        format.html { render :edit }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1/save_purchase
  def save_purchase
    respond_to do |format|
      if @paper.update(paper_purchase_params)
        format.html { redirect_to purchase_book_paper_path(@book, @paper), notice: 'Paper was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper }
      else
        format.html { render :edit }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Paper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find_by_token(params[:book_token])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = @book.papers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :description, :currency)
    end

    def paper_purchase_params
      params.require(:paper).permit(items_attributes: [:id, :name, :quantity, :price, :unit])
    end
end
