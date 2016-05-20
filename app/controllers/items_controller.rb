class ItemsController < ApplicationController
  authorize_resource :class => false

  def load_page
    redirect_to input_items_path
  end

  def index
    @items = InventoryItem.all
  end

  def show
    @supplier = AccountObject.where(AccountObjectID: params[:id])
    @items = InventoryItem.all
    @selected_items = @supplier[0].item
    # binding.pry
    gon.selected_items = @selected_items
  end

  def insert
    list_items = InventoryItem.where(InventoryItemID: params[:list_items]) #lisst truyen len
    list_supplier= Item.where(supplier_id: params[:supplier_id]) #list mat hang theo nha cung cap da co
    if params[:list_items].blank?
      list_supplier.destroy_all
    else
      if list_supplier.blank?
        list_items.each do |item|
          params_create = {item_id: item.InventoryItemID,
                           item_code: item.InventoryItemCode,
                           supplier_id: params[:supplier_id]}
          Item.create(params_create)
        end
      else
        temp = list_supplier.where(item_id: params[:list_items]) # mat hang da co theo nha cung cap voi item truyen len 
        list_item_id = temp.map(&:item_id) #tao mang item_id cua item da co
        list_temp = params[:list_items] - list_item_id if params[:list_items].present?#truyen len ma chua co
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
        list_item_not_select = Item.where(supplier_id: params[:supplier_id]).map(&:item_id)
        # temp = Item.where(supplier_id: params[:supplier_id]).where(item_id: params[:list_items]).map(&:item_id) # mat hang da co theo nha cung cap voi item truyen len 
        # list_item_id = temp.map(&:item_id)
        list_temp_not_params = list_item_not_select - params[:list_items] if params[:list_items].present?
        if list_temp_not_params.present?
          Item.where(item_id: list_temp_not_params).where(supplier_id: params[:supplier_id]).destroy_all
        end
      end
    end
    redirect_to item_path(params[:supplier_id])
  end

  def suppliers
    @suppliers = AccountObject.where(isVendor: 1)
  end

  def input
    # puorders = PuOrderDetail.all.map(&:InventoryItemID).uniq
    # @items = InventoryItem.where(InventoryItemID: puorders)
    @items = PuOrderDetail.all.includes(:inventory_item,:item).group_by(&:InventoryItemID)
     
    #@items = pu_order_detail.includes(:inventory_item)
    #binding.pry
    items_suppliers = Item.all 
    gon.items_suppliers = items_suppliers
    gon.account_object = AccountObject.where(isVendor: 1)
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

