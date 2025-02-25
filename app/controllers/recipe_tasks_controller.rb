class RecipeTasksController < ApplicationController
  def index
    matching_recipe_tasks = RecipeTask.all

    @list_of_recipe_tasks = matching_recipe_tasks.order({ :created_at => :desc })

    render({ :template => "recipe_tasks/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_tasks = RecipeTask.where({ :id => the_id })

    @the_recipe_task = matching_recipe_tasks.at(0)

    render({ :template => "recipe_tasks/show" })
  end

  def create
    the_recipe_task = RecipeTask.new
    the_recipe_task.recipe_id = params.fetch("query_recipe_id")
    the_recipe_task.task_id = params.fetch("query_task_id")

    if the_recipe_task.valid?
      the_recipe_task.save
      redirect_to("/recipe_tasks", { :notice => "Recipe task created successfully." })
    else
      redirect_to("/recipe_tasks", { :alert => the_recipe_task.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_task = RecipeTask.where({ :id => the_id }).at(0)

    the_recipe_task.recipe_id = params.fetch("query_recipe_id")
    the_recipe_task.task_id = params.fetch("query_task_id")

    if the_recipe_task.valid?
      the_recipe_task.save
      redirect_to("/recipe_tasks/#{the_recipe_task.id}", { :notice => "Recipe task updated successfully."} )
    else
      redirect_to("/recipe_tasks/#{the_recipe_task.id}", { :alert => the_recipe_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_task = RecipeTask.where({ :id => the_id }).at(0)

    the_recipe_task.destroy

    redirect_to("/recipe_tasks", { :notice => "Recipe task deleted successfully."} )
  end
end
