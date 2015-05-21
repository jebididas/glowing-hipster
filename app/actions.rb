# Homepage (Root path)
get '/' do
  erb :index
end

post '/plusones/new' do 
  erb :'plusones/new'
end
