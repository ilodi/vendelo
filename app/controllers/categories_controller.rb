class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order(name: :asc)
  end

  def new
    @category = Category.new
  end

  def edit
    category
  end
  
  def create
    @category = Category.new(category_params)

      if @category.save
        redirect_to categories_url(@category), notice: t('.created')
      else
        render :new, status: :unprocessable_entity 
      end

  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    
      if category.update(category_params)
        redirect_to categories_url(@category), notice: t('.updated') 
      else
        render :edit, status: :unprocessable_entity 
      end
   
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    category.destroy
      redirect_to categories_url, notice: t('.destroyed')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
