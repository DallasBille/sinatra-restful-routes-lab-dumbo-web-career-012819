require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
      @recipes = Recipe.all
     #binding.pry
      erb :index
  end


    get  '/recipes/new' do
        erb :new
    end

    post '/recipes' do
        @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
        # binding.pry

        redirect to "/recipes/#{@recipe.id}"
    end

   get  '/recipes/:id' do
       @recipes = Recipe.find_by_id(params[:id])
       erb :show
   end

   delete '/recipes/:id' do
       @recipes = Recipe.find_by_id(params[:id])
       @recipes.delete
       redirect to '/recipes'
   end

   get '/recipes/:id/edit' do
       @recipe = Recipe.find_by_id(params[:id])
       erb :edit
   end

   patch '/recipes/:id' do
       #binding.pry
       @recipe = Recipe.find_by_id(params[:id])
       @recipe.name = params[:name]
       @recipe.ingredients = params[:ingredients]
       @recipe.cook_time = params[:cook_time]
       @recipe.save
       redirect to "/recipes/#{@recipe.id}"
   end
end
