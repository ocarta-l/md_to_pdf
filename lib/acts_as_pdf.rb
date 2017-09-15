module ActsAsPdf
  extend ActiveSupport::Concern

  @@pdf_options = Hash.new { |hash, key| hash[key] = Hash.new { |hash, key| hash[key] = Hash.new } }
  cattr_accessor :pdf_options

  def md_pdf args = []
    hash = self.send(ActsAsPdf.pdf_options[self.class.to_s.downcase][:opts][:method], *args) rescue {}
    output = md_to_pdf

    font_size = ActsAsPdf.pdf_options[self.class.to_s.downcase][:opts][:font_size] || '10'

    hash.each { |k, v| output.gsub!(k.to_s, v.to_s) }
    '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' + "<style type = 'text/css'> body { font-family: 'Futura'; font-size: #{font_size}; line-height:180%;  }</style>" + output
  end

  def md_to_pdf
    pipeline = ::HTML::Pipeline.new [
        ::HTML::Pipeline::MarkdownFilter
      ]
      result = pipeline.call self.send(ActsAsPdf.pdf_options[self.class.to_s.downcase][:field]).gsub(/[\n|^ ][ |\t]+/){ |m| m.gsub(/ |\t/, '&nbsp;') }.gsub("\n", "<br>")
      result[:output].to_s
  end

  def preview params
    return self unless params[:preview]

    model_name = self.class.to_s.downcase.to_sym
    field_name = ActsAsPdf.pdf_options[self.class.to_s.downcase][:field]

    model = self.class.new
    model.send("#{field_name}=", params[model_name][field_name])
    model
  end

  def generate_pdf params, args = []
    convention = self.preview params
    WickedPdf.new.pdf_from_string(convention.md_pdf(args))
  end

  module ClassMethods

    def acts_as_pdf field, opts = {}
      ActsAsPdf.pdf_options[self.to_s.downcase][:opts] = opts
      ActsAsPdf.pdf_options[self.to_s.downcase][:field] = field
    end

  end
end

ActiveRecord::Base.send(:include, ActsAsPdf)
