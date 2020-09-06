class RecipesController < ApplicationController
  before_action :require_login


  def index
    @recipes = Recipe.all
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end


#  def create
#    @recipe = Recipe.new(recipe_params)
#
#    if @recipe.save
#      redirect_to recipe_path(@recipe), notice: "Recipe Creation Successfull"
#    else
#      @errors = @recipe.errors.full_messages
#      render :new
#    end
#  end
  def create
  new_recipe_record = current_user.recipes.new(recipe_params)
  if new_recipe_record.save
    redirect_to recipes_path notice: 'Recipe Created'
#guitar created successfully for current logged in user
  else
     #current_user.recipe.errors.full_messages
  end
end
  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path, notice: "Successfully Deleted: #{recipe.name}"
  end

private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
