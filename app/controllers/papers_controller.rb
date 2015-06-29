class PapersController < ApplicationController
  before_action :set_book
  before_action :set_paper, only: [:show, :edit, :update, :destroy]

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

    @paper = @book.papers.new
    @paper.title = Time.now.strftime('%Y-%m-%d')
  end

  # GET /papers/1/edit
  def edit
    @title = "Edit - #{@paper.title}"
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = @book.papers.new(paper_params)

    respond_to do |format|
      if @paper.save
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
        format.html { redirect_to [@book, @paper], notice: 'Paper was successfully updated.' }
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
      params.require(:paper).permit(:title)
    end
end
