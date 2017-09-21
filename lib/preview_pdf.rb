module PreviewPdfAddOn
  extend ActiveSupport::Concern

  module ClassMethods
    def preview_pdf opts = {}

      define_method :preview do
      
        name_view = opts[:view] || 'preview.pdf'
        @pdf = resource.generate_pdf params
        raise "#{params.inspect}"
        if params[:preview]
          render name_view
        else
          route = params[:commit].split(' ').first.downcase.to_sym
          send(route) if [:create, :update].include? route
        end
      end
    end
  end
end

class ActionController::Base
  include PreviewPdfAddOn
end
