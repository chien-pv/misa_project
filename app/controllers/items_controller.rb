class ItemsController < ApplicationController
  def index
    @items = InventoryItem.all
  end

  def show
    @supplier = AccountObject.where(AccountObjectID: params[:id])
    @items = InventoryItem.all
    @selected_items = @supplier[0].item
  end

  def insert
    list_items = InventoryItem.where(InventoryItemID: params[:list_items]) #lisst truyen len
    list_supplier= Item.where(supplier_id: params[:supplier_id]) #list mat hang theo nha cung cap da co
    if list_supplier.blank?
      list_items.each do |item|
        params_create = {item_id: item.InventoryItemID,
                         item_code: item.InventoryItemCode,
                         supplier_id: params[:supplier_id]}
        Item.create(params_create)
      end
    else
      # binding.pry
      temp = list_supplier.where(item_id: params[:list_items]) # mat hang da co theo nha cung cap voi item truyen len 
      list_item_id = temp.map(&:item_id) #tao mang item_id cua item da co
      list_temp = params[:list_items] - list_item_id #truyen len ma chua co
        if list_temp.present?
          list_items = InventoryItem.where(InventoryItemID: list_temp)
          list_items.each do |item|
            params_create = {item_id: item.InventoryItemID,
                             item_code: item.InventoryItemCode,
                             supplier_id: params[:supplier_id]}
            item_search = Item.find_by(item_id: item.InventoryItemID, supplier_id: nil)
            if item_search.present?
              # binding.pry
              item_search.update(supplier_id: params[:supplier_id] )
            else
              Item.create(params_create)
            end
          end
        end
      # binding.pry
      list_item_not_select = Item.where(supplier_id: params[:supplier_id]).map(&:item_id)
      # temp = Item.where(supplier_id: params[:supplier_id]).where(item_id: params[:list_items]).map(&:item_id) # mat hang da co theo nha cung cap voi item truyen len 
      # list_item_id = temp.map(&:item_id)
      list_temp_not_params = list_item_not_select - params[:list_items]
      if list_temp_not_params.present?
        binding.pry
        Item.where(item_id: list_temp_not_params).where(supplier_id: params[:supplier_id]).destroy_all
      end
    end
    redirect_to item_path(params[:supplier_id])
  end

  def suppliers
    @suppliers = AccountObject.all
  end

  def input
    @items = InventoryItem.includes(:item).all
    @items_suppliers = Item.all
    @suppliers = AccountObject.all
  end
end
