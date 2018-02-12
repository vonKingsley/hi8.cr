module HI8
  module Cabinet
    class FileSystem
      include Cabinet

      def initialize
      end

      def store(file_name : String, content)
        abso_path = absolute_path_to_file(file_name)
        create_path(abso_path)
        File.write(abso_path, content) if abso_path && File.exists?(File.dirname(abso_path))
      end

      def watch(file_name : String)
        path = absolute_path_to_file(file_name)
        File.read(path) if path && File.exists?(path)
      end

      def delete(file_name : String)
        path = absolute_path_to_file(file_name)
        FileUtil.rm(path) if path && File.exists?(path)
      end

      private def absolute_path_to_file(file_name)
        File.join(HI8.configuration.cabinet_shelf, file_name)
      end

      private def absolute_path_for(path)
        Dir.cd(path) { Dir.current }
      end

      private def create_path(absolute)
        Dir.mkdir_p(File.dirname(absolute)) unless Dir.exists?(File.dirname(absolute))
      end
    end
  end
end
