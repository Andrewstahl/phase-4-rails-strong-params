class BirdsController < ApplicationController
  # The reason for this is that Rails by default will wrap JSON parametersLinks to an external site. as a nested hash under a key based on the name of the controller (in our case, bird since we're in a BirdsController). This is the reason that in the Rails server log, even with our strong params in place, you'll still see Unpermitted parameters: :bird for our requests.
  wrap_parameters format: []

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  private

  # When we call params.permit(:name, :species), this will return a new hash with only the name and species keys. Rails will also mark this new hash as permitted, which means we can safely use this new hash for mass assignment
  def bird_params
    params.permit(:name, :species)
  end

end
