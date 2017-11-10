module HI8
  module Cabinet
    class FileSystem
      include Cabinet

      getter storage_location : String

      def initialize
        @storage_location = HI8.configuration.cassette_library_dir
      end

      def storage_location=(dir)
        Dir.mkdir_p(dir) unless Dir.exists?(dir)
        @storage_location = Dir.exists?(dir) ? absolute_path_for(dir) : "."
      end

      def store(file_name, content)
        self.storage_location = HI8.configuration.cassette_library_dir
        path = absolute_path_to_file(file_name)
        File.write(path, content) if path && File.exists?(File.dirname(path))
      end

      def watch(file_name)
        path = absolute_path_to_file(file_name)
        File.read(path) if path && File.exists?(path)
      end

      def delete(file_name)
        path = absolute_path_to_file(file_name)
        FileUtil.rm(path) if path && File.exists?(path)
      end

      private def absolute_path_to_file(file_name)
        if (storage_location && file_name)
          return File.join(storage_location, file_name)
        end
        nil
      end

      private def absolute_path_for(path)
        Dir.cd(path) { Dir.current }
      end
    end
  end
end
