class MenusController < ApplicationController
  def index
    matching_menus = Menu.all

    @list_of_menus = matching_menus.order({ :created_at => :desc })

    render({ :template => "menus/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_menus = Menu.where({ :id => the_id })

    @the_menu = matching_menus.at(0)

    render({ :template => "menus/show" })
  end

  def create
    the_menu = Menu.new
    the_menu.event_id = params.fetch("query_event_id")
    the_menu.recipe_id = params.fetch("query_recipe_id")
    the_menu.remarks = params.fetch("query_remarks")

    if the_menu.valid?
      the_menu.save
      redirect_to("/menus", { :notice => "Menu created successfully." })
    else
      redirect_to("/menus", { :alert => the_menu.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_menu = Menu.where({ :id => the_id }).at(0)

    the_menu.event_id = params.fetch("query_event_id")
    the_menu.recipe_id = params.fetch("query_recipe_id")
    the_menu.remarks = params.fetch("query_remarks")

    if the_menu.valid?
      the_menu.save
      redirect_to("/menus/#{the_menu.id}", { :notice => "Menu updated successfully."} )
    else
      redirect_to("/menus/#{the_menu.id}", { :alert => the_menu.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_menu = Menu.where({ :id => the_id }).at(0)

    the_menu.destroy

    redirect_to("/menus", { :notice => "Menu deleted successfully."} )
  end
end
