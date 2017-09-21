module PreviewPdfAddOn
  extend ActiveSupport::Concern

  module ClassMethods
    def preview_pdf opts = {}

      define_method :preview do
      
        name_method = opts[:method] || resource.name_method
        name_view = opts[:view] || 'preview.pdf'
        @pdf = resource.send(name_method, params)
        render name_view if params[:preview]

      end
    end
  end
end

class ActionController::Base
  include PreviewPdfAddOn
end
