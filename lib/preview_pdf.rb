module PreviewPdf
  extend ActiveSupport::Concern

  module ClassMethods 

    def preview
      name_method = resource.name_method
      @pdf = resource.send(name_method, params)
      render 'preview.pdf' if params[:preview]
    end

  end
end
