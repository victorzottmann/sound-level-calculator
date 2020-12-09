
module Validators
  def self.validate_input(input)
    num_input = input.to_i
    if num_input > 0 && num_input < 5
      return true
    else
      return false
    end
  end
end