# Homepage (Root path)
get '/' do
  erb :index
end

post '/plusones/new' do 
  erb :'plusones/new'
end

post '/' do
  @user = User.create(
    username: params[:username],
    password: params[:password],
    email: params[:email]
    )
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'user/new'
  end
end

