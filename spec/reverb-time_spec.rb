
require '../reverb-time'

describe reverb_time(room_volume, absoption) do
  it 'checks if the reverb time is above 0' do
    expect(reverb_time(200, 45)).to eq(true)

    expect(reverb_time(0, 0)).to eq(false)
    expect(reverb_time(-2, 4)).to eq(false)
    expect(reverb_time(-2, -10)).to eq(false)
    expect(reverb_time("hfjkafh", 13)).to eq(false)
    expect(reverb_time("gjdflg", "fhdsfgjd")).to eq(false)
  end
end