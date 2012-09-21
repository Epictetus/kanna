module Pera
  module ControllerAdditions
    extend ActiveSupport::Concern

    included do
      before_filter :set_pera_format
    end

    module InstanceMethods
      def set_pera_format
        request.format = :pera if request.headers["HTTP_X_PERA"]
      end
    end
  end
end
