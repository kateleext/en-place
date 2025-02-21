class DishesController < ApplicationController
  def index
    matching_dishes = Dish.all

    @list_of_dishes = matching_dishes.order({ :created_at => :desc })

    render({ :template => "dishes/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_dishes = Dish.where({ :id => the_id })

    @the_dish = matching_dishes.at(0)

    render({ :template => "dishes/show" })
  end

  def create
    the_dish = Dish.new
    the_dish.event_id = params.fetch("query_event_id")
    the_dish.description = params.fetch("query_description")
    the_dish.course = params.fetch("query_course")
    the_dish.recipe = params.fetch("query_recipe")

    if the_dish.valid?
      the_dish.save
      redirect_to("/dishes", { :notice => "Dish created successfully." })
    else
      redirect_to("/dishes", { :alert => the_dish.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_dish = Dish.where({ :id => the_id }).at(0)

    the_dish.event_id = params.fetch("query_event_id")
    the_dish.description = params.fetch("query_description")
    the_dish.course = params.fetch("query_course")
    the_dish.recipe = params.fetch("query_recipe")

    if the_dish.valid?
      the_dish.save
      redirect_to("/dishes/#{the_dish.id}", { :notice => "Dish updated successfully."} )
    else
      redirect_to("/dishes/#{the_dish.id}", { :alert => the_dish.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_dish = Dish.where({ :id => the_id }).at(0)

    the_dish.destroy

    redirect_to("/dishes", { :notice => "Dish deleted successfully."} )
  end
end
