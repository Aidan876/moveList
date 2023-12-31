class Api::V1::MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :update, :destroy]

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    render json: @movie
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie, status: :created
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    head :no_content
  end

  private

  def set_movie
    @movie = Movie.find_by(id: params[:id])
    unless @movie
      render json: { error: 'Movie not found' }, status: :not_found
    end
  end

  def movie_params
    params.require(:movie).permit(:name, :genre)
  end
end
