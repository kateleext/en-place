Rails.application.routes.draw do
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

  # Routes for the Dish task resource:

  # CREATE
  post("/insert_dish_task", { :controller => "dish_tasks", :action => "create" })
          
  # READ
  get("/dish_tasks", { :controller => "dish_tasks", :action => "index" })
  
  get("/dish_tasks/:path_id", { :controller => "dish_tasks", :action => "show" })
  
  # UPDATE
  
  post("/modify_dish_task/:path_id", { :controller => "dish_tasks", :action => "update" })
  
  # DELETE
  get("/delete_dish_task/:path_id", { :controller => "dish_tasks", :action => "destroy" })

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

  # Routes for the Dish resource:

  # CREATE
  post("/insert_dish", { :controller => "dishes", :action => "create" })
          
  # READ
  get("/dishes", { :controller => "dishes", :action => "index" })
  
  get("/dishes/:path_id", { :controller => "dishes", :action => "show" })
  
  # UPDATE
  
  post("/modify_dish/:path_id", { :controller => "dishes", :action => "update" })
  
  # DELETE
  get("/delete_dish/:path_id", { :controller => "dishes", :action => "destroy" })

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

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
