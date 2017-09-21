module InheritedResources

  class Base < ::ApplicationController

    def self.preview_pdf(base)
      base.class_eval do

        respond_to :html if self.mimes_for_respond_to.empty?
        self.responder = InheritedResources::Responder

      end
    end

    # preview_pdf(self)
  end
end