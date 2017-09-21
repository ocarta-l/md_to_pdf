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


ActiveSupport.on_load(:action_controller) do
  if self == ActionController::Base
    def self.preview_pdf
      PreviewPdf::Base.preview_pdf(self)
      # initialize_resources_class_accessors!
      # create_resources_url_helpers!
    end
  end
end
