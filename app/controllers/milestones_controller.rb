class MilestonesController < ApplicationController
  def index
    matching_milestones = Milestone.all

    @list_of_milestones = matching_milestones.order({ :created_at => :desc })

    render({ :template => "milestones/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_milestones = Milestone.where({ :id => the_id })

    @the_milestone = matching_milestones.at(0)

    render({ :template => "milestones/show" })
  end

  def create
    the_milestone = Milestone.new
    the_milestone.event_id = params.fetch("query_event_id")
    the_milestone.name = params.fetch("query_name")

    if the_milestone.valid?
      the_milestone.save
      redirect_to("/milestones", { :notice => "Milestone created successfully." })
    else
      redirect_to("/milestones", { :alert => the_milestone.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_milestone = Milestone.where({ :id => the_id }).at(0)

    the_milestone.event_id = params.fetch("query_event_id")
    the_milestone.name = params.fetch("query_name")

    if the_milestone.valid?
      the_milestone.save
      redirect_to("/milestones/#{the_milestone.id}", { :notice => "Milestone updated successfully."} )
    else
      redirect_to("/milestones/#{the_milestone.id}", { :alert => the_milestone.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_milestone = Milestone.where({ :id => the_id }).at(0)

    the_milestone.destroy

    redirect_to("/milestones", { :notice => "Milestone deleted successfully."} )
  end
end
