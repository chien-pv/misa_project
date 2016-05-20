class InventoryItemsController < ApplicationController
  authorize_resource :class => false
  def index
    @inventorys = InventoryItem.all
  end
end
