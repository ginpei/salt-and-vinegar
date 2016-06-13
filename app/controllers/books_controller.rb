class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :item_history, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @title = @book.name
    @papers = @book.papers.order('created_at DESC')
    @paper = @book.current_paper

    @items = @paper.items.all
    @new_item = @paper.items.new
    @new_item.orderer = session[:orderer]
  end

  # GET /books/new
  def new
    @book = Book.new
    @book.taxes.new
  end

  # GET /books/1/edit
  def edit
    if @book.taxes.count < 1
      @book.taxes.new
    end
  end

  # GET /papers/1/select_recent_items
  def select_recent_items
    @book = Book.find_by_token(params[:book_token])
    @current_paper = @book.current_paper
    @recent_papers = @book.recent_papers

    @title = "Edit - #{@book.current_paper.title}"
  end

  # GET /books/1/item_history
  def item_history
    @items = []
    @book.recent_papers.each do |paper|
      @items += paper.items.map do |item|
        {
          paper_title: item.paper.title,
          name: item.name,
          quantity: item.quantity,
          order: item.quantity,
          orderer: item.orderer,
          price: item.price,
          unit: item.unit,
        }
      end
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        @book.papers.create(
          title: 'First Paper',
          description: 'This is your first paper. Add some items you want!'
        )

        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /papers/1/copy_recent_items
  def copy_recent_items
    @book = Book.find_by_token(params[:book_token])
    @paper = @book.copy_recent_items(params[:last_item])

    respond_to do |format|
      if @paper.save
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find_by_token(params[:token])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(
        :name, :token, :default_currency,
        taxes_attributes: [:id, :rate]
      )
    end
end
