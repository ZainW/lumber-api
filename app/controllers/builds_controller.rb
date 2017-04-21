class BuildsController < ApplicationController
  before_action :get_items
  def make
    @build = {:hp => 0, :str => 0, :agi => 0, :int => 0, :mana => 0, :armor => 0, :damage => 0, :hpregen => 0, :evasion => 0, :attackspeed => 0, :manaregen => 0, :movespeed => 0, :itemcost => 0}
    @items.each do |item|
      @build.keys.each do |key|
        @build[key] += item.more[key.to_s].to_i
      end
    end
    render json: @build
  end
  private
  def get_items
    @items = []
    items = params.select { |key, value| key.to_s.match(/^item\d+/) }
    items.each do |key, item|
      @items << Item.search("#{item}").results.first
    end
  end
end
