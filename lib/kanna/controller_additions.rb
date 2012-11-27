module Kanna
  module ControllerAdditions
    extend ActiveSupport::Concern

    included do
      before_filter :set_kanna_format
    end

    module InstanceMethods
      def set_kanna_format
        request.format = :kanna if request.headers["HTTP_X_KANNA"]
      end
    end
  end
end
