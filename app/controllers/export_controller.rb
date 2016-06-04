class ExportController < ApplicationController
   def index
    @list_unit = Unit.all
    @list_map = MapPurchase.all.map(&:map_id).uniq
    if params[:list_map].nil?
      @list_order = MapPurchase.where( map_id: @list_map.first)
    else
      @list_order = MapPurchase.where( map_id: params[:list_map])
    end
    respond_to do |format| 
      format.xlsx {render xlsx: 'export_file',filename: "#{@list_order[0].map_id}.xlsx"}
    end
  end
end
