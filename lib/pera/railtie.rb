module Pera
  class Railtie < ::Rails::Railtie
    initializer "pera" do |app|
      ActiveSupport.on_load(:action_controller) do
        require "pera/controller_additions"
        ::ActionController::Base.send :include, Pera::ControllerAdditions
      end

      ActiveSupport.on_load(:action_view) do
        require "pera/actionview_lookup_context_ext"
      end

      Mime::Type.register_alias "text/javascript", :pera

      if Rails.env.development?
        app.config.middleware.use Rack::Static, urls: ['/www'], root: "app/pera"
      end
    end

    rake_tasks do
      load "pera/tasks/pera.rake"
    end
  end
end