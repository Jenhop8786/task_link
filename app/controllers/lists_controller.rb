class ListsController < ApplicationController
#INDEX
  get '/lists' do
    redirect_if_not_logged_in
    @lists = List.all
    erb :'lists/index'
  end

  get '/lists/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'lists/new'
  end

#EDIT
  get '/lists/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @list = List.find(params[:id])
    if @list.user != current_user
      redirect "/lists/new?error=Hey! That list wasn't yours to mess with."
    end
    erb :'lists/edit'
  end

  post "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    unless List.valid_params?(params)
      redirect "/lists/#{@list.id}/edit?error=invalid list"
    end
    @list.update(params.select{|k|k== "name"})
    redirect "/lists/#{@list.id}"
  end

#SHOWS
  get "/lists/:id" do
    redirect_if_not_logged_in
    @list = List.find(params[:id])
    if @list.user != current_user
      redirect "/lists/new?error=Hey! That list wasn't yours to mess with."
    else
      erb :'lists/show'
    end
  end

  post "/lists" do
    redirect_if_not_logged_in

    unless List.valid_params?(params)
      redirect "/lists/new?error=invalid list"
    end
    current_user.lists.create(params)
    redirect '/lists'
  end

 #DELETE ACTION

  delete '/lists/:id' do
    @list = List.find_by_id(params[:id])
    if @list.user_id == current_user.id
    @list.destroy
    redirect '/lists'
  else
    redirect '/lists'
  end
 end
end#class
