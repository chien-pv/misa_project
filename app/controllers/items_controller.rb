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
      list_item_not_select = list_supplier.map(&:item_id)
      list_temp_not_params = list_item_not_select - list_item_id
        if list_temp.present?
          list_items = InventoryItem.where(InventoryItemID: list_temp)
          list_items.each do |item|
            params_create = {item_id: item.InventoryItemID,
                             item_code: item.InventoryItemCode,
                             supplier_id: params[:supplier_id]}
            if item_search = Item.find_by(item_id: item.InventoryItemID, supplier_id: nil).present?
              item_search.update(supplier_id: params[:supplier_id] )
            else
              Item.create(params_create)
            end
          end
        end
      # binding.pry
      if list_temp_not_params.present?
         # binding.pry
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

  def add_information
    #binding.pry
    supplier_list = params[:supplier_list]
    if Item.where(item_id: params[:selected_item_id]).blank?
        params_create = {item_id: params[:selected_item_id],
                         weight: params[:weight],
                         volume: params[:volume]}
        Item.create(params_create)
    else
      if supplier_list.blank?
        Item.find_by(item_id: params[:selected_item_id]).update(weight: params[:weight],volume: params[:volume])
      else
        supplier_list.each do |supplier|
          Item.find_by(item_id: params[:selected_item_id], supplier_id: supplier[:supplier_id]).update(weight: params[:weight],volume: params[:volume],supplier_item_code: supplier[:itemid])
        end
      end
    end
    redirect_to input_items_path
  end
end
