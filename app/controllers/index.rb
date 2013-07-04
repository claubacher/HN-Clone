get '/' do
  erb :index
end

post '/login' do
  if User.authenticate!(params[:name], params[:password])
    @user = User.authenticate!(params[:name], params[:password])
    session[:user_id] = @user.id
    redirect '/posts'
  else
    @errors = "Username or password was invalid."
    erb :index
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/signup' do
  erb :signup
end

post '/create_user' do
  @user = User.new(:name => params[:name])
  @user.password = params[:password]
  if @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect '/posts'
  else
    @errors = @user.errors.full_messages
    erb :signup
  end
end

get '/posts' do
  @posts = Post.all
  erb :posts
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :full_post
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/users/:id/posts' do
  @posts = User.find(params[:id]).posts
  erb :posts
end

get '/users/:id/comments' do
  @comments = User.find(params[:id]).comments
  erb :comments
end