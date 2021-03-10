# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.all_ratings
    @sort_by = params[:sort_by]
    @ratings = params[:ratings] || Hash.new { |hash,key| 1 }

    search_keys = @ratings.keys

    @movies = search_keys.empty? ? Movie.all : search_keys.map { |rate| Movie.where(rating: rate) }.flatten.compact
    
    @movies = @movies.sort_by { |movie| movie[@sort_by] }
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
end