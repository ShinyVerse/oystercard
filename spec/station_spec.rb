require 'station'

describe Station do

  it 'should have a name' do
    station = Station.new("Aldgate East", 1)
    expect(station).to have_attributes(name: "Aldgate East", zone: 1)
  end

end
