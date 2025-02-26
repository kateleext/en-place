class RecipesController < ApplicationController
  require "dotenv/load"

  def form
    render(template:"recipes/form")
  end
  
  def index
    matching_recipes = Recipe.all
    @list_of_recipes = matching_recipes.order({ :created_at => :desc })
    render({ :template => "recipes/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_recipes = Recipe.where({ :id => the_id })
    @the_recipe = matching_recipes.at(0)
    render({ :template => "recipes/show" })
  end

  def structured_output(system_prompt, user_prompt, schema)
    messages_array = [
      {"role" => "system", "content" => system_prompt},
      {"role" => "user", "content" => user_prompt}
    ]
    response_format = JSON.parse("{
      \"type\": \"json_schema\",
      \"json_schema\": #{schema}
    }")
    request_headers_hash = {
      "Authorization" => "Bearer #{ENV.fetch("OPENAI_API_KEY")}",
      "content-type" => "application/json"
    }
    request_body_hash = {
      "model" => "gpt-4o",
      "response_format" => response_format,
      "messages" => messages_array
    }
    request_body_json = JSON.generate(request_body_hash)
    raw_response = HTTP.headers(request_headers_hash).post(
      "https://api.openai.com/v1/chat/completions",
      :body => request_body_json
    ).to_s
    parsed_response = JSON.parse(raw_response)
    message_content = parsed_response.dig("choices", 0, "message", "content")
    structured_output = JSON.parse(message_content)
    return structured_output
  end

  def plan
    guest_count = params.fetch("guest_count")
    recipe = Recipe.all.where(:id => params.fetch("recipe_id"))
    system_prompt = "You are a thoughtful, proactive and detail-oriented home kitchen manager planning for busy night serving guests. Your objective is to help the chef get through the night with calm and confidence. Given one or more recipes in structured format + how many people we need to serve these dish(es) to tonight, please plan the following:

        1. A unified shopping list, combining from multiple recipes that use the same ingredients. Keep in mind that recipe quantities in the original recipe are meant for single serving. 
        2. A list of well-sequenced and concise tasks based on the HowToSteps across different recipes, grouped under high-level milestones (Examples of milestones include "Night Before", "Wash and Chop", "Mixing Liquids", "Garnish & Serve"). Please include ingredient quantities when mentioning them in each task. 

        In writing the tasks, follow the below principles:

        - Take timing and sequencing into consideration; e.g. steps that take longer might be better done first, things that need to be served hot should be handled last. 
        - Consider the utensils and tools that would be required for each step, and group them accordingly. The goal is to maintain a neat kitchen by putting away what we no longer need.
        - When a step is long, break it down into distinct, concrete tasks, prioritizing critical information in the title and any additional details in remarks. Your chef will be busy and need to be able to glance at the screen and know what to do next. 
        - Include critical details within the task itself, such as quantities of ingredients, utensils to use
        - in general, the chef should be able to make all decisions based off the task summary and description alone, and never have to refer back to the ingredients list"
    user_prompt = recipe + "The above single-serve recipe needs to be adjusted for #{guest_count} people."
    plan_schema = '{
        "name": "kitchen_plan",
        "strict": true,
        "schema": {
          "type": "object",
          "properties": {
            "shopping_list": {
              "type": "array",
              "description": "A list of ingredients required for the recipe.",
              "items": {
                "type": "object",
                "properties": {
                  "item": {
                    "type": "string",
                    "description": "The name of the ingredient."
                  },
                  "quantity": {
                    "type": "string",
                    "description": "The amount required for the ingredient."
                  }
                },
                "required": [
                  "item",
                  "quantity"
                ],
                "additionalProperties": false
              }
            },
            "milestones": {
              "type": "array",
              "description": "A list of milestones in the kitchen plan.",
              "items": {
                "type": "object",
                "properties": {
                  "name": {
                    "type": "string",
                    "description": "Description of the milestone"
                  },
                  "tasks": {
                    "type": "array",
                    "description": "A list of steps detailing the kitchen tasks.",
                    "items": {
                      "type": "object",
                      "properties": {
                        "task_summary": {
                          "type": "string",
                          "description": "Concise summary of the task"
                        },
                        "details": {
                          "type": "string",
                          "description": "Additional reminders and tips for the task"
                        }
                      },
                      "required": [
                        "task_summary",
                        "details"
                      ],
                      "additionalProperties": false
                    }
                  }
                },
                "required": [
                  "name",
                  "tasks"
                ],
                "additionalProperties": false
              }
            }
          },
          "required": [
            "shopping_list",
            "milestones"
          ],
          "additionalProperties": false
        }
      }'
    plan = structured_output(system_prompt, user_prompt, plan_schema)

    #create event
    event = Event.new
    event.event_date = Date.today
    event.guest_count = guest_count
    event.save

    #save milestones
    for milestone in plan.milestones
      new_milestone = Milestone.new
      new_milestone.event_id = event.id
      new_milestone.name = milestone.name
      new_milestone.save
      for task in milestone.tasks
        new_task = Task.new
        new_task.milestone_id = new_milestone.id
        new_task.title = task.task_summary
        new_task.description = task.details
        new_task.save
      end
    end
    #save ingredients
    for ingredient in plan.shopping_list
      new_ingredient = Ingredient.new
      new_ingredient.name = ingredient.item
      new_ingredient.quantity = ingredient.quantity
      new_ingredient.event_id = event.id
      new_ingredient.save
    end

    redirect("events/#{:event.id}/tasks")
  end

  def generate(recipe)
    system_prompt = "You are a chef advisor within a recipe application. Given a descriptive name of a dish, generate a recipe. Please assume one single serving for ingredient quantities. Add \\/n tags in between bullets to create line breaks."
    user_prompt = "#{recipe.name}: #{recipe.description}. Note: #{recipe.note}"
    recipe_schema = '{ 
      "name": "recipe", 
      "schema": { 
        "type": "object", 
        "properties": { 
          "ingredients": { 
            "type": "string", 
            "description": "bulleted list of ingredients in the recipe, separated with \n for line breaks" 
          }, 
          "steps": { 
            "type": "string", 
            "description": "bulleted list of steps to cook the recipe, separated with \n for line breaks" 
          } 
        }, 
        "required": ["ingredients", "steps"], 
        "additionalProperties": false 
      }, 
      "strict": true 
    }'
    
    generated_recipe = structured_output(system_prompt, user_prompt, recipe_schema)
    return generated_recipe 
  end

  def create
    @the_recipe = Recipe.new
    @the_recipe.user_id = current_user.id
    @the_recipe.name = params.fetch("query_name")
    @the_recipe.description = params.fetch("query_description")
    @the_recipe.note = params.fetch("query_note")
    @the_recipe.reference_url = params.fetch("query_reference_url")

    if @the_recipe.description != nil
      recipe_draft = generate(@the_recipe)
      @the_recipe.ingredients = recipe_draft.fetch("ingredients")
      @the_recipe.steps = recipe_draft.fetch("steps")
    end

    if @the_recipe.valid?
      @the_recipe.save
      redirect_to("/recipes/#{@the_recipe.id}", { :notice => "Recipe created successfully." })
    else
      redirect_to("/recipes", { :alert => @the_recipe.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.user_id = params.fetch("query_user_id")
    the_recipe.name = params.fetch("query_name")
    the_recipe.description = params.fetch("query_description")
    the_recipe.reference_url = params.fetch("query_reference_url")
    the_recipe.ingredients = params.fetch("query_ingredients")
    the_recipe.steps = params.fetch("query_steps")
    the_recipe.note = params.fetch("query_note")

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes/#{the_recipe.id}", { :notice => "Recipe updated successfully."} )
    else
      redirect_to("/recipes/#{the_recipe.id}", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)
    the_recipe.destroy
    redirect_to("/recipes", { :notice => "Recipe deleted successfully."} )
  end
end
