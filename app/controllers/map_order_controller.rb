class MapOrderController < ApplicationController
  def index
    @purchase_order = PurchaseOrder.where(status: [0, 1]).order(:RefDate)
  end

  def create
    @list_order = PurchaseOrder.includes(:pu_order_detail).where(RefID: params[:list_orders])
    @list_container  = ContainerType.all
  end

  def creates
    map_id = Time.now.strftime("%Y%d%m%H%M%S")
    params[:Pu].each do |pu|
      # binding.pry
      MapPurchase.create(map_id: map_id , RefID: pu[:RefID], date_map: Time.now.strftime("%Y-%d-%m %H:%M:%S %Z"))
      pu[:Item].each do |item|
        MapItem.create(ItemID: item[:InventoryItemID], map_purchase_id: MapPurchase.find_by(RefID: pu[:RefID], map_id: map_id).id, quantity: item[:quantity]  )
      end
    end
    redirect_to map_order_index_path
  end

end
