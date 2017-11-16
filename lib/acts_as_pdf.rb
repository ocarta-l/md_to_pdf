require 'preview_pdf'

module ActsAsPdf
  extend ActiveSupport::Concern

  @@pdf_options = {}
  cattr_accessor :pdf_options

  def md_pdf args = []
    hash = self.send(ActsAsPdf.pdf_options[self.class.to_s.downcase][:opts][:method], *args) rescue {}
    output = md_to_pdf

    opts = ActsAsPdf.pdf_options[self.class.to_s.downcase][:opts]
    font_name = opts[:font_name] || 'Futura'
    font_size = opts[:font_size] || '10'
    line_height = opts[:line_height] || '180%'

    hash.each { |k, v| output.gsub!(k.to_s, v.to_s) }
    "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'> <style type = 'text/css'> body { font-family: #{font_name}; font-size: #{font_size}; line-height: #{line_height};  }</style> " + output
  end

  def md_to_pdf
    pipeline = ::HTML::Pipeline.new [
        ::HTML::Pipeline::MarkdownFilter
      ]
      result = pipeline.call self.send(ActsAsPdf.pdf_options[self.class.to_s.downcase][:field]).gsub(/[\n|^ ][ |\t]+/){ |m| m.gsub(/ |\t/, '&nbsp;') }.gsub("\n", "<br>")
      result[:output].to_s# .gsub(/\"/, "'")
  end

  def name_method
    ActsAsPdf.pdf_options[self.class.to_s.downcase][:opts][:method] rescue nil
  end

  def preview params
    return self unless params[:preview]

    model_name = self.class.to_s.underscore.to_sym
    field_name = ActsAsPdf.pdf_options[self.class.to_s.downcase][:field]

    model = self.class.new
    model.send("#{field_name}=", params[model_name][field_name])
    model
  end

  def generate_pdf params, args = []
    model = self.preview params
    WickedPdf.new.pdf_from_string(model.md_pdf(args), ActsAsPdf.pdf_options[self.class.to_s.downcase][:opts])
  end

  module ClassMethods

    def acts_as_pdf field, opts = {}
      ActsAsPdf.pdf_options[self.to_s.downcase] ||= {}
      ActsAsPdf.pdf_options[self.to_s.downcase][:opts] = opts
      ActsAsPdf.pdf_options[self.to_s.downcase][:field] = field
    end

  end
end

ActiveRecord::Base.send(:include, ActsAsPdf)
