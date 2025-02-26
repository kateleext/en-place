Rails.application.routes.draw do

  #------------------------------
  # Routes for the Event resource:

  #FORM TO CREATE A NEW EVENT FROM A MENU
  get("/events/new", controller: "events", action: "form")

  # CREATE
  post("/create_event", { :controller => "events", :action => "create" })
          
  # READ
  get("/events", { :controller => "events", :action => "index" })
  get("/events/:path_id", { :controller => "events", :action => "show" }) #redirects to event tasks
    #Review all recipes in an event
  get("/events/:path_id/recipes", controller: "events", action: "show_recipes")
  get("/events/:path_id/tasks", controller: "events", action: "show_tasks")
  get("/events/:path_id/ingredients", controller: "events", action: "show_ingredients")

  
  # UPDATE
  post("/modify_event/:path_id", { :controller => "events", :action => "update" })
  
  # DELETE
  get("/delete_event/:path_id", { :controller => "events", :action => "destroy" })

  # ARCHIVE EVENT
  post("/events/:path_id/archive", controller: "events", action: "archive")
 #------------------------------

  # Routes for the Recipe resource:
  get("/recipes/new", controller: "recipes", action:"form")
  # CREATE NEW RECIPE
  post("/create_recipe", { :controller => "recipes", :action => "create" })
          
  # READ
  get("/recipes", { :controller => "recipes", :action => "index" })
  get("/recipes/:path_id", { :controller => "recipes", :action => "show" })

  # UPDATE
  post("/modify_recipe/:path_id", { :controller => "recipes", :action => "update" })
  
  # DELETE
  get("/delete_recipe/:path_id", { :controller => "recipes", :action => "destroy" })

  #------------------------------

  # Routes for the Milestone resource:

  # CREATE
  post("/insert_milestone", { :controller => "milestones", :action => "create" })
   
  # UPDATE
  post("/modify_milestone/:path_id", { :controller => "milestones", :action => "update" })
  
  # DELETE
  get("/delete_milestone/:path_id", { :controller => "milestones", :action => "destroy" }) #note: need to implement dependency so its associated tasks are also destroyed

  #------------------------------

  # Routes for the Task resource:

  # CREATE
  post("/insert_task", { :controller => "tasks", :action => "create" })
          
  # UPDATE
  post("/modify_task/:path_id", { :controller => "tasks", :action => "update" })
  get("/check_task/:path_id", controller:"tasks", action:"check")

  # DELETE
  get("/delete_task/:path_id", { :controller => "tasks", :action => "destroy" })

  #------------------------------

  # Routes for the Ingredient resource:

  # CREATE
  post("/insert_ingredient", { :controller => "ingredients", :action => "create" })
  # UPDATE
  post("/modify_ingredient/:path_id", { :controller => "ingredients", :action => "update" })
  get("/check_ingredient/:path_id", controller:"ingredients", action:"check")
  
  # DELETE
  get("/delete_ingredient/:path_id", { :controller => "ingredients", :action => "destroy" })

  #------------------------------
  devise_for :users
  
end
