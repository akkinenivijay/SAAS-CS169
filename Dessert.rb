class Dessert
  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  def healthy?()
    @calories < 200
  end

  def delicious?()
    true
  end

  attr_accessor :name, :calories
end

des = Dessert.new("VIjay", 220)
p des.name

des.name = 'Vijay'
p des.healthy?
p des.delicious?

class JellyBean < Dessert

  attr_accessor :flavor

  def initialize(name, calories, flavor)
    super name, calories
    @flavor = flavor
  end

  def delicious?
    if (@flavor.downcase == "BlackLicorice".downcase || @flavor.downcase == 'black licorice')
      return false
    else
      super
    end
  end
end

jb = JellyBean.new("vijay", 250, "trawberyy")
p jb.delicious?
p jb.healthy?
p jb.name

jb.flavor = 'strawberry'
p jb.flavor
