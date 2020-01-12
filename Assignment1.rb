# Example 1 REFACTORED:
def get_addresses
    Address.where.not(city_id: nil)
end
  
# Example 2 REFACTORED:
  class Greeting
    attr_accessor :name
  end
  
# Example 3 REFACTORED:
  def sum(*values)
    values.inject(0, :+)
  end
  
