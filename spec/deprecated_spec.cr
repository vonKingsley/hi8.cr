it "deprecates cassette_library_dir" do
  HI8.configure { |conf| conf.cassette_library_dir = "./spec/deprecated" }
  HI8.configuration.cabinet_shelf.should eq "./spec/deprecated"
end
