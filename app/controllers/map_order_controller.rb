class MapOrderController < ApplicationController
  authorize_resource :class => false
  def index
    @purchase_order = PurchaseOrder.where(status: [0, 1]).order(:RefDate)
  end

  def create
    @list_order = PurchaseOrder.includes(:pu_order_detail).where(RefID: params[:list_orders])
    @list_container  = ContainerType.all
    @list_unit = Unit.all
  end

  def creates
    params[:Pu].each do |pu|
      MapPurchase.create(map_id: pu[:name] , RefID: pu[:RefID], date_map: Time.now.strftime("%Y-%d-%m %H:%M:%S %Z"))
      pu[:Item].each do |item|
        MapItem.create(ItemID: item[:InventoryItemID], map_purchase_id: MapPurchase.find_by(RefID: pu[:RefID], map_id: pu[:name]).id, quantity: item[:quantity]  )
      end
    end
    redirect_to map_order_index_path
  end

end
