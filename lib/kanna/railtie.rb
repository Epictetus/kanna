module Kanna
  class Railtie < ::Rails::Railtie
    initializer "kanna" do |app|
      ActiveSupport.on_load(:action_controller) do
        require "kanna/controller_additions"
        ::ActionController::Base.send :include, Kanna::ControllerAdditions
      end

      ActiveSupport.on_load(:action_view) do
        require "kanna/actionview_lookup_context_ext"
      end

      Mime::Type.register_alias "text/javascript", :kanna

      if Rails.env.development?
        app.config.middleware.use Rack::Static, urls: ['/www'], root: "app/kanna"
      end
    end

    rake_tasks do
      load "kanna/tasks/kanna.rake"
    end
  end
end
