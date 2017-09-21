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
          route = params[:commit].split(' ').first.downcase.to_sym
          send(route) if [:create, :update].include? route
        end
      end

      define_method :create do
      
        if params[:preview]
          send('preview')
        else
          super
        end
      end

    end
  end
end

class ActionController::Base
  include PreviewPdfAddOn
end
