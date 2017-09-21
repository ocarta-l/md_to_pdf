module PreviewPdfAddOn
  extend ActiveSupport::Concern

  module ClassMethods
    def preview_pdf opts = {}

      define_method :preview do
      
        name_view = opts[:view] || 'preview.pdf'
        @pdf = resource.generate_pdf params
        if params[:preview]
          render name_view
        else
          send(params[:commit].split(' ').first.downcase)
        end
      end
    end
  end
end

class ActionController::Base
  include PreviewPdfAddOn
end
