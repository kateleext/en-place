desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  if Rails.env.development?
    User.destroy_all
    Event.destroy_all
    Dish.destroy_all
    Ingredient.destroy_all
    Milestone.destroy_all
    Task.destroy_all
    DishTask.destroy_all
  end

  usernames=["Kate", "Neal", "Alex", "Gabbi"]
  usernames.each do |username|
    user = User.new
    user.email = "#{username.downcase}@enplace.ai"
    user.password = "password"
    user.save
  end

  5.times do 
    event = Event.new
    event.user_id = User.all.sample.id
    event.event_date = Date.today
    event.guest_count = rand(3..10)
    event.description = nil
    event.save
  end
end
