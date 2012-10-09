require 'rails/generators'

module Pera
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy Pera default files"
      source_root File.expand_path('../templates', __FILE__)

      def create_app_pera_dir
        empty_directory Rails.root.join("app/pera")
      end

      def create_ios_dir_and_copy_files
        create_base_dir_and_copy_files('app/pera/ios')
      end

      def create_src_dir_and_copy_files
        create_base_dir_and_copy_files("app/pera/src/css")
        create_base_dir_and_copy_files("app/pera/src/haml")
        create_base_dir_and_copy_files("app/pera/src/js")
      end

      def create_www_dir_and_copy_files
        create_base_dir_and_copy_files('app/pera/www/vendor')
      end

      def copy_guard_file
        copy_file "Guardfile", "Guardfile"
      end

      def add_guard_to_gemfile
        gem 'guard-haml', group: :development
        gem 'guard-sass', group: :development
        gem 'guard-coffeescript', group: :development
        gem 'rb-fsevent', group: :development
      end
    private

      def create_base_dir_and_copy_files(base)
        app_dir = Rails.root.join(base)
        empty_directory app_dir
        template_dir = File.join(self.class.source_root, base)
        copy_files(base)
      end

      def copy_files(base)
        filename_pattern = File.join(self.class.source_root, base, "*")
        Dir.glob(filename_pattern).map{|f| File.basename(f)}.each do |f|
          path = "#{base}/#{f}"
          copy_file path, path
        end
      end
    end
  end
end
