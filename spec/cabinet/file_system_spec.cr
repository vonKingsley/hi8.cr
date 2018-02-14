require "../spec_helper"

Spec.after_each do
  empty_cabinet_shelf
end

describe HI8::Cabinet::FileSystem do
  it "stores a file" do
    shelf = "named.json"
    fs = HI8::Cabinet::FileSystem.new
    fs.store(shelf, "")
    File.exists?(File.expand_path(File.join(HI8.configuration.cabinet_shelf, shelf))).should be_true
  end

  it "stores a path" do
    shelf = "one/path.json"
    fs = HI8::Cabinet::FileSystem.new
    fs.store(shelf, "")
    File.exists?(File.expand_path(File.join(HI8.configuration.cabinet_shelf, shelf))).should be_true
  end

  it "stores a path with leading slash" do
    shelf = "/one/path_slash.json"
    fs = HI8::Cabinet::FileSystem.new
    fs.store(shelf, "")
    File.exists?(File.expand_path(File.join(HI8.configuration.cabinet_shelf, shelf))).should be_true
  end

  it "stores a nested path" do
    shelf = "one/two/three/nested_path.json"
    fs = HI8::Cabinet::FileSystem.new
    fs.store(shelf, "")
    File.exists?(File.expand_path(File.join(HI8.configuration.cabinet_shelf, shelf))).should be_true
  end

  it "stores a nested path with leading slash" do
    shelf = "/one/two/three/nested_path_slash.json"
    fs = HI8::Cabinet::FileSystem.new
    fs.store(shelf, "")
    File.exists?(File.expand_path(File.join(HI8.configuration.cabinet_shelf, shelf))).should be_true
  end
end
