helpers do
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end

  def current_date
    (Time.now + Time.zone_offset('PDT')).to_date
  end

  def current_week
    current_date.strftime("%U").to_i
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

# get '/users/:id' do
#   @user = User.find params[:id]
#   erb :'users/summary'  
# end

get '/plusones/new' do
  erb :'/plusones/new'
end

post '/plusones/new' do
  @plusone = Plusone.create(
    score: params[:score].to_i,
    user_id: current_user.id,
    p_date: current_date)
  # @activity = Activity.create(
  #   description: params[:description],
  #   plusone_id: @plusone.id)
  if @plusone.save
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

get '/users/:id/plusones/:date' do
  @date = Date.strptime("{#{params[:date]}}", "{%y%m%d}")
  @user = User.find params[:id]
  erb :'/plusones/show'
end

get '/users/edit' do
  erb :'/users/edit'
end

get '/users/upload' do
  if current_user
    erb :'/users/upload'
  else
    redirect '/login'
  end
end

post "/users/upload" do 
  File.open("public/images/users/#{current_user.id}/" + "default-user.png", "w") do |f|
    f.write(params[:myfile][:tempfile].read)
  end
  redirect '/users/edit'
end


post '/users/edit' do
  if current_user
    current_user.update(
      username: params[:username],
      email: params[:email],
      password: params[:password])
    if current_user.save
      redirect '/'
    else
      redirect '/users/edit'
    end
  else
    redirect '/login'
  end
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

get '/cohorts/new' do
  erb :'/cohorts/new'
end

post '/cohorts/new' do
  @cohort = Cohort.create(
    name: params[:name],
    c_public: params[:c_pulic],
    admin: current_user.id)
  @enrollment = Enrollment.create(
    user_id: current_user.id,
    cohort_id: @cohort.id,
    enrollment_date: current_date)
  redirect '/' if @cohort.save && @enrollment.save
end

get '/cohorts/:id/index' do
  @cohort = Cohort.find params[:id]
  erb :'cohorts/index'  
end

get '/cohorts/:id/:date' do
  @cohort = Cohort.find params[:id]
  @date = Date.strptime("{#{params[:date]}}", "{%y%m%d}")
  erb :'cohorts/summary'  
end
