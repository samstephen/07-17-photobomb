
get '/home' do
  if session[:user_id]
  else
    redirect "/login"
  end



  erb :'main/home'
end

get '/login' do
  erb :'main/login'
end

get "/login-validation" do

  username = params["username"]
  a = ActiveRecord::Base.connection.execute("SELECT password FROM users WHERE email = '#{username}';")

  binding.pry

  a = a[0]["password"]

  user_password = BCrypt::Password.new(a)

  if params["password"] == user_password
    session[:user_id] = 1
  else
    session[:user_id] = 0
  end


end

get "/add-user-form" do
  erb :"user/add-user-form"
end

get "/view_users" do
  users = User.all
  json_array = []
  users.each do |d|
    json_array << d.json_format
  end
  json json_array
end

post "/save-user" do
  password = BCrypt::Password.create(params["password"])
  new_user = User.create({email: params["email"], password:  password})
  json new_user.json_format
end