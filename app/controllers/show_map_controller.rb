class ShowMapController < ApplicationController
  authorize_resource :class => false
  def index
    @list_unit = Unit.all
    @list_map = MapPurchase.all.map(&:map_id).uniq
    @list_map = MapPurchase.where("map_id LIKE '%#{params[:name]}%'").map(&:map_id).uniq if params[:name].present?
    if params[:list_map].nil?
      @list_order = MapPurchase.where( map_id: @list_map.first)
    else
      @list_order = MapPurchase.where( map_id: params[:list_map])
    end
  end

  def delete_map_order
    if params[:list_map].present?
      params[:list_map].each do |id|
        map_purchase = MapPurchase.find_by_id(id)
        if map_purchase.map_item.destroy_all
          map_purchase.destroy
        end
      end
    end
    redirect_to show_map_index_path
  end
end
