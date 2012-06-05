class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name
    attr_reader attr_name+"_history"
    class_eval %Q"
            def #{attr_name}=(value)
                if !defined? @#{attr_name}_history
                    @#{attr_name}_history = [@#{attr_name}]
                end
                @#{attr_name} = value
                @#{attr_name}_history << value
            end
        "
  end
end

class Foo
  attr_accessor_with_history :bar
  attr_accessor_with_history :foo
end


foo = Foo.new
foo.bar = 5
foo.bar = 10

foo.foo =10
foo.foo = 20


p foo.bar_history

p foo.foo_history

module Enumerable
  def palindrome?
    if self.is_a? Hash
      return false
    end
    self == self.reverse_each.to_a
  end
end

p [1, 2, 3, 2, 4].palindrome?
x = {}.palindrome?
p x

class String
  def palindrome?
    strippedString = self.to_s.downcase.gsub(/\W/, '')
    reversedString = strippedString.reverse
    reversedString == strippedString
  end
end

p "ana".palindrome?
p "Madam, I'm Adam!".palindrome?

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019,'dollar' => 1}

  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub(/s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end

  def in(key)
    current_currency = key.to_s
    singular_currency = current_currency.to_s.gsub(/s$/, '')
    if @@currencies.has_key? singular_currency
      conversion_rate = @@currencies[singular_currency]
      self / conversion_rate
    else
      super
    end
  end
end

p 1000.dollars.in(:euros)
