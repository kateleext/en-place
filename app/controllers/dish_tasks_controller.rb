class DishTasksController < ApplicationController
  def index
    matching_dish_tasks = DishTask.all

    @list_of_dish_tasks = matching_dish_tasks.order({ :created_at => :desc })

    render({ :template => "dish_tasks/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_dish_tasks = DishTask.where({ :id => the_id })

    @the_dish_task = matching_dish_tasks.at(0)

    render({ :template => "dish_tasks/show" })
  end

  def create
    the_dish_task = DishTask.new
    the_dish_task.dish_id = params.fetch("query_dish_id")
    the_dish_task.task_id = params.fetch("query_task_id")

    if the_dish_task.valid?
      the_dish_task.save
      redirect_to("/dish_tasks", { :notice => "Dish task created successfully." })
    else
      redirect_to("/dish_tasks", { :alert => the_dish_task.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_dish_task = DishTask.where({ :id => the_id }).at(0)

    the_dish_task.dish_id = params.fetch("query_dish_id")
    the_dish_task.task_id = params.fetch("query_task_id")

    if the_dish_task.valid?
      the_dish_task.save
      redirect_to("/dish_tasks/#{the_dish_task.id}", { :notice => "Dish task updated successfully."} )
    else
      redirect_to("/dish_tasks/#{the_dish_task.id}", { :alert => the_dish_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_dish_task = DishTask.where({ :id => the_id }).at(0)

    the_dish_task.destroy

    redirect_to("/dish_tasks", { :notice => "Dish task deleted successfully."} )
  end
end
