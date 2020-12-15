
require '../validators'

describe Validators.validate_surface_area do
  it 'checks if the surface area is above 0' do
    expect(Validators.validate_surface_area(0)).to eq(false)
    expect(Validators.validate_surface_area(-1)).to eq(false)
    expect(Validators.validate_surface_area("khkfda")).to eq(false)

    expect(Validators.validate_surface_area(15)).to eq(true)
    expect(Validators.validate_surface_area(6.82)).to eq(true)  
  end
end

describe Validators.validate_material do
  it 'checks if the material choice is a positive integer' do
    expect(Validators.validate_material(1)).to be(1)
    expect(Validators.validate_material(2)).to be(2)

    expect(Validators.validate_material("jkfhafkd")).to eq(false)
    expect(Validators.validate_material(0)).to eq(false)
    expect(Validators.validate_material(-1)).to eq(false)
  end
end

