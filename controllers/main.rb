set :sessions => true

before do
  if session["user_id"]
    @user = User.find(session["user_id"])
  end
end



get '/home' do
  erb :'main/home'
end

get '/login' do
  erb :'main/login'
end

get "/login-validation" do

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