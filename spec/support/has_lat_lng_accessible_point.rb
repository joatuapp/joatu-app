RSpec.shared_examples "it has a lat lng accessible point" do |column_prefix| 
  it "responds to #{column_prefix}_latitude" do
    expect(subject).to respond_to :"#{column_prefix}_latitude"
  end

  it "parses that latitude out of the geo field and returns it" do
    latitude = rand(179)
    subject.send("#{column_prefix}=", "POINT(10 #{latitude})")
    expect(subject.send("#{column_prefix}_latitude").to_f).to eq latitude.to_f
  end

  it "responds to #{column_prefix}_longitude" do
    expect(subject).to respond_to :"#{column_prefix}_longitude"
  end

  it "parses the longitude out of the geo field and returns it" do
   longitude = rand(179)
   subject.send("#{column_prefix}=", "POINT(#{longitude} 10)")
   expect(subject.send("#{column_prefix}_longitude").to_f).to eq longitude.to_f
  end

  it "has a setter on latitude that updates the underlying point" do
    latitude = rand(179)
    subject.send("#{column_prefix}_latitude=", latitude)
    expect(subject.send("#{column_prefix}_latitude").to_f).to eq latitude.to_f
  end

  it "has a setter on longitude that updates the underlying point" do
    longitude = rand(179)
    subject.send("#{column_prefix}_longitude=", longitude)
    expect(subject.send("#{column_prefix}_longitude").to_f).to eq longitude.to_f
  end
end
