module MapOrderHelper

  def show_unit(unit_id)
    @list_unit.find{|u| u.UnitID == unit_id }.try(:UnitName)
  end

  def volume(volume, quantity)
    volume = volume.nil? ? 0 : volume
    volume*quantity
  end

  def weight(weight, quantity)
    weight = weight.nil? ? 0 : weight
    weight*quantity
  end
end
