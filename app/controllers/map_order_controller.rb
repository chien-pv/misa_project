class MapOrderController < ApplicationController
  def index
    @purchase_order = PurchaseOrder.where(status: [0, 1]).order(:RefDate)
  end

  def create
    @list_order = PurchaseOrder.includes(:pu_order_detail).where(RefID: params[:list_orders])
  end

  def creates
    # binding.pry
    map_id = Time.now.strftime("%Y%d%m%H%M%S")
    params[:Pu].each do |pu|
      MapPurchase.create(map_id: map_id , RefID: pu[:RefID], date_map: Time.now.strftime("%Y-%d-%m %H:%M:%S %Z"))
      pu[:Item].each do |item|
        MapItem.create(ItemID: item[:InventoryItemID], map_purchase_id: MapPurchase.find_by(RefID: pu[:RefID]).id, quantity: item[:quantity]  )
      end
    end
  end

end
