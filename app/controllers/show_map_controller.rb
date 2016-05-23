class ShowMapController < ApplicationController
  authorize_resource :class => false
  def index
    # binding.pry
    @list_unit = Unit.all
    @list_map = MapPurchase.all.map(&:map_id).uniq
    @list_map = MapPurchase.where("map_id LIKE '%#{params[:name]}%'").map(&:map_id).uniq if params[:name].present?
    if params[:list_map].nil?
      @list_order = MapPurchase.where( map_id: @list_map.first)
    else
      @list_order = MapPurchase.where( map_id: params[:list_map])
    end
  end
end
