require 'rails/generators'

module Kanna
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy Kanna default files"
      source_root File.expand_path('../templates', __FILE__)

      def create_app_kanna_dir
        empty_directory Rails.root.join("app/kanna")
      end

      def create_ios_dir_and_copy_files
        create_base_dir_and_copy_files('app/kanna/ios')
      end

      def create_src_dir_and_copy_files
        create_base_dir_and_copy_files("app/kanna/src/css")
        create_base_dir_and_copy_files("app/kanna/src/haml")
        create_base_dir_and_copy_files("app/kanna/src/js")
      end

      def create_www_dir_and_copy_files
        create_base_dir_and_copy_files('app/kanna/www/vendor')
      end

      def copy_guard_file
        copy_file "Guardfile", "Guardfile"
      end

      def add_guard_to_gemfile
        gem_group :development do
          gem 'guard-haml', require: false
          gem 'guard-sass', require: false
          gem 'guard-coffeescript', require: false
          gem 'rb-fsevent', require: false
        end
      end

      def copy_kanna_config_file
        copy_file "config/kanna.yml"
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
