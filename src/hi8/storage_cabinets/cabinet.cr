require "./*"
module HI8
  module Cabinet
    abstract def watch(file_name : String)
    abstract def store(file_name : String, content : Cabinet)
  end
end
