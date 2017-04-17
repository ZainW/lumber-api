class AbilitiesController < ApplicationController
  before_action :set_hero
  before_action :set_hero_ability, only: [:show, :update, :destroy]

  # GET /abilities
  def index
    @abilities = @hero.abilities

    render json: @abilities
  end

  # GET /abilities/1
  def show
    render json: @ability
  end

  # POST /abilities
  def create
    @ability = Ability.new(ability_params)
    @ability.hero_id = @hero.id
    if @ability.save!
      render json: @ability, status: :created
    end
  rescue => error
    render_unprocessable_entity_response(error)
  end

  # PATCH/PUT /abilities/1
  def update
    if @ability.update(ability_params)
      render json: @ability
      head :nocontent
    end
    rescue
      render_unprocessable_entity_response(error)
    # else
    #   render json: @ability.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /abilities/1
  def destroy
    @ability.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero_ability
      @ability = @hero.abilities.where("more->>'hotkey' = ?", "#{params[:hotkey]}").first if @hero
      if @ability == nil
        @ability = Ability.find_by!(name: "nil")
      end

    end

    # Only allow a trusted parameter "white list" through.
    def ability_params
      params.permit(:name, :more, :hero_id)
    end
    def set_hero
      search = Hero.search "#{params[:hero_name]}", fields: [:name]
      if search.results == []
        Hero.find_by!(name: "nil")
      else
        @hero = search.results.first
      end
    end
end
