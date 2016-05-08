module MapOrderHelper

  def show_unit(unit_id)
    Unit.where(UnitID: unit_id)[0].try(:UnitName)
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
