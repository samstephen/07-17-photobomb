get '/home' do
  erb :'/main/home'
end

get '/login' do
  erb :'main/login'
end

get "/add-user-form" do
  erb :"user/add-user-form"
end

post "/save_user" do
  password = BCrypt::Password.create(params["password"])
  new_user = User.create({email:  params["email"], password:  password})
  json new_user.json_format
end