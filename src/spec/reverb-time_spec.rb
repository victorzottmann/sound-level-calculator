
require '../reverb-time'

describe sabine(room_volume, absoption) do
  it 'checks if the reverb time is above 0' do
    expect(sabine(200, 45)).to eq(true)

    expect(sabine(0, 0)).to eq(false)
    expect(sabine(-2, 4)).to eq(false)
    expect(sabine(-2, -10)).to eq(false)
    expect(sabine("hfjkafh", 13)).to eq(false)
    expect(sabine("gjdflg", "fhdsfgjd")).to eq(false)
  end
end