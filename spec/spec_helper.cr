require "spec"
require "../src/hi8"

ASSETS = File.expand_path("#{File.dirname(__FILE__)}/assets")

def empty_cabinet_shelf
  dir = HI8.configuration.cabinet_shelf
  FileUtils.rm_r(dir) if Dir.exists?(dir)
end
