class HeroesController < ApplicationController
  before_action :set_hero, only: [:show, :update, :destroy]

  # GET /heroes
  def index
    @heroes = Hero.all

    render json: @heroes
  end

  # GET /heroes/Alchemist
  def show
    render json: @hero
  end

  # POST /heroes
  def create
    @hero = Hero.new(hero_params)

    if @hero.save
      render json: @hero, status: :created, location: @hero
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heroes/1
  def update
    if @hero.update(hero_params)
      render json: @hero
      head :no_content
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heroes/1
  def destroy
    @hero.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Hero.find_by!(name: params[:name])
    end

    # Only allow a trusted parameter "white list" through.
    def hero_params
      params.permit(:name, :profile_url, :base_str, :base_agi, :base_int, :add_str, :add_agi, :add_int, :move_speed, :turn_rate, :attack_type, :talents, :attack_range, :hero_type)
    end
end
