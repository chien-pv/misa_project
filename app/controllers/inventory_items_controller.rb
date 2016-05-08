class InventoryItemsController < ApplicationController
  def index
    @inventorys = InventoryItem.all
  end
end
