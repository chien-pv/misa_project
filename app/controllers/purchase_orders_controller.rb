class PurchaseOrdersController < ApplicationController
  authorize_resource :class => false
  def index
    @purchase_orders =  PurchaseOrder.all
  end

  def show
    @list_unit = Unit.all
    @purchase_order =  PurchaseOrder.where(RefID: params[:id])
    @detail_pus = @purchase_order[0].pu_order_detail
  end

  # def get_data
  #   @inventory_items = InventoryItem.all
  #   @inventory_items.each do |item|
  #     params_create = {item_id: item.InventoryItemID,
  #                      item_code: item.InventoryItemCode}
  #     Item.create(params_create)
  #   end
  #   redirect_to purchase_order_path(params[:format])
  # end

end
