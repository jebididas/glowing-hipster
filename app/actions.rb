helpers do
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
  def current_day
    @current_day = Date.today
  end
end

# Homepage (Root path)
get '/' do
  erb :'index'
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
  # redirect '/user/:id'
end

get '/logout' do
  session.delete :user_id
  redirect '/'
end

get '/user/:id' do
  @user = User.find params[:id]
  @plusones = @user.plusones
  erb :'users/summary'  
end

get '/plusones/new' do
  erb :'/plusones/new'
end

post '/plusones/new' do
  @plusone = Plusone.create(
    score: params[:score].to_i,
    user_id: current_user.id,
    p_date: current_day)
  @activity = Activity.create(
    description: params[:description],
    plusone_id: @plusone.id)
  if @plusone.save && @activity.save
    redirect '/plusones'
  else
    redirect '/plusones/new'
  end
end

get '/plusones' do
  if current_user
    erb :'/plusones/index'
  else
    redirect '/login'
  end
end

get '/edit' do
  erb :'edit'
end

get '/plusones/update' do
  @user = User.first # will be changed later
  # @plusones = @user.plusones
  erb :'/plusones/update'
end

post '/plusones/update' do

  @plusone = Plusone.create(
    score: params[:score],
    user_id: current_user.id)
  @activity = Activity.create(
    description: params[:description],
    plusone_id: @plusone.id)
  if @plusone.save && @activity.save
    redirect '/plusones'
  end
end


