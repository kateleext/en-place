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

  def generate(recipe)
    system_prompt = "You are a chef advisor within a recipe application. Given a descriptive name of a dish, generate a recipe. Please assume one single serving for ingredient quantities. Add <br> html tags in between bullets to create line breaks."
    user_prompt = "#{recipe.name}: #{recipe.description}. Note: #{recipe.note}"
    messages_array = [
      {"role" => "system", "content" => system_prompt},
      {"role" => "user", "content" => user_prompt}
    ]
    recipe_schema = '{ 
      "name": "recipe", 
      "schema": { 
        "type": "object", 
        "properties": { 
          "ingredients": { 
            "type": "string", 
            "description": "bulleted list of ingredients in the recipe, separated with <br> for line breaks" 
          }, 
          "steps": { 
            "type": "string", 
            "description": "bulleted list of steps to cook the recipe, separated with <br> for line breaks" 
          } 
        }, 
        "required": ["ingredients", "steps"], 
        "additionalProperties": false 
      }, 
      "strict": true 
    }'

    response_format = JSON.parse("{
      \"type\": \"json_schema\",
      \"json_schema\": #{recipe_schema}
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
