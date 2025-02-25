Rails.application.routes.draw do
  # Routes for the Recipe task resource:

  # CREATE
  post("/insert_recipe_task", { :controller => "recipe_tasks", :action => "create" })
          
  # READ
  get("/recipe_tasks", { :controller => "recipe_tasks", :action => "index" })
  
  get("/recipe_tasks/:path_id", { :controller => "recipe_tasks", :action => "show" })
  
  # UPDATE
  
  post("/modify_recipe_task/:path_id", { :controller => "recipe_tasks", :action => "update" })
  
  # DELETE
  get("/delete_recipe_task/:path_id", { :controller => "recipe_tasks", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe ingredient resource:

  # CREATE
  post("/insert_recipe_ingredient", { :controller => "recipe_ingredients", :action => "create" })
          
  # READ
  get("/recipe_ingredients", { :controller => "recipe_ingredients", :action => "index" })
  
  get("/recipe_ingredients/:path_id", { :controller => "recipe_ingredients", :action => "show" })
  
  # UPDATE
  
  post("/modify_recipe_ingredient/:path_id", { :controller => "recipe_ingredients", :action => "update" })
  
  # DELETE
  get("/delete_recipe_ingredient/:path_id", { :controller => "recipe_ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Menu resource:

  # CREATE
  post("/insert_menu", { :controller => "menus", :action => "create" })
          
  # READ
  get("/menus", { :controller => "menus", :action => "index" })
  
  get("/menus/:path_id", { :controller => "menus", :action => "show" })
  
  # UPDATE
  
  post("/modify_menu/:path_id", { :controller => "menus", :action => "update" })
  
  # DELETE
  get("/delete_menu/:path_id", { :controller => "menus", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe resource:

  # CREATE
  post("/insert_recipe", { :controller => "recipes", :action => "create" })
          
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
          
  # READ
  get("/milestones", { :controller => "milestones", :action => "index" })
  
  get("/milestones/:path_id", { :controller => "milestones", :action => "show" })
  
  # UPDATE
  
  post("/modify_milestone/:path_id", { :controller => "milestones", :action => "update" })
  
  # DELETE
  get("/delete_milestone/:path_id", { :controller => "milestones", :action => "destroy" })

  #------------------------------

  # Routes for the Task resource:

  # CREATE
  post("/insert_task", { :controller => "tasks", :action => "create" })
          
  # READ
  get("/tasks", { :controller => "tasks", :action => "index" })
  
  get("/tasks/:path_id", { :controller => "tasks", :action => "show" })
  
  # UPDATE
  
  post("/modify_task/:path_id", { :controller => "tasks", :action => "update" })
  
  # DELETE
  get("/delete_task/:path_id", { :controller => "tasks", :action => "destroy" })

  #------------------------------

  # Routes for the Ingredient resource:

  # CREATE
  post("/insert_ingredient", { :controller => "ingredients", :action => "create" })
          
  # READ
  get("/ingredients", { :controller => "ingredients", :action => "index" })
  
  get("/ingredients/:path_id", { :controller => "ingredients", :action => "show" })
  
  # UPDATE
  
  post("/modify_ingredient/:path_id", { :controller => "ingredients", :action => "update" })
  
  # DELETE
  get("/delete_ingredient/:path_id", { :controller => "ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Event resource:

  # CREATE
  post("/insert_event", { :controller => "events", :action => "create" })
          
  # READ
  get("/events", { :controller => "events", :action => "index" })
  
  get("/events/:path_id", { :controller => "events", :action => "show" })
  
  # UPDATE
  
  post("/modify_event/:path_id", { :controller => "events", :action => "update" })
  
  # DELETE
  get("/delete_event/:path_id", { :controller => "events", :action => "destroy" })

  #------------------------------

  devise_for :users
  
end
