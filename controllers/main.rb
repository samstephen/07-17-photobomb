
# enable :sessions

get '/home' do
  if session[:user_id] != nil
  else
    redirect "/login"
  end
  erb :'main/home'
end

get '/login' do
  erb :'main/login'
end

get "/login-validation" do

    # @user = User.find_by_email(params[:email])
    # if @user.password == params[:password]
    #   give_token
    # else
    #   redirect_to "main/login"
    # end


    @user = User.find_by_email!(params["email"])

    # entered_email = params["users"]["email"]
    # user_email = User.find_email(entered_email)



    if !@user.nil?
      @valid = true
      given_pw = params["password"]
      actual_pw = BCrypt::Password.new(@user.password)
      if actual_pw == given_pw

        session[:id] = @user.id


        binding.pry

        erb :"main/home"
      else
        @valid = false
        erb :"main/login"
      end
    else
      @valid = false
      erb :"main/login"
    end





      # if @user[:passwordhash] == BCrypt::Engine.hash_secret(params["password"])
      #   session[:username] = params[:username]
      #   redirect "/"
      # end



end



  # username = params["username"]
  # a = ActiveRecord::Base.connection.execute("SELECT password FROM users WHERE email = '#{username}';")
  #
  # a = a[0]["password"]
  #
  # user_password = BCrypt::Password.new(a)
  #
  # binding.pry
  #
  #
  #
  # if params["password"] == user_password
  #   session[:user_id] = 1
  #   erb :"main/home"
  # else
  #   erb :"main/login"
  # end




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