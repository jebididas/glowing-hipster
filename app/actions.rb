helpers do
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

post '/' do # Register new user
  @user = User.create(
    username: params[:username],
    password: params[:password],
    email: params[:email]
    )
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'index'
  end
end

get '/login' do
  erb :'login'
end

post '/login' do
  @user = User.find_by username: params[:username]
  if @user
    if params[:password] == @user.password
      session[:user_id] = @user.id
    end
  end
  redirect '/'
end

get '/logout' do
  session.delete :user_id
  redirect '/'
end

get '/plusones/new' do
  erb :'/plusones/new'
end

post '/plusones/new' do
  @plusone = Plusone.create(
    score: params[:score],
    user_id: current_user.id)
  if @plusone.save
    redirect '/'
  end
end

get '/edit' do
  erb :'edit'
end



