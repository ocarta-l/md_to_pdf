# ActsAsPdf

Quick way to convert markdown to pdf.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'acts_as_pdf'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install acts_as_pdf
```

You may need:
```ruby
gem 'html-pipeline'
gem 'wicked_pdf'
gem 'prawn_rails'
```

## Usage

**model.rb**
```ruby
class Model < ApplicationRecord

  validates_presence_of :field

  acts_as_pdf :field, {method: :generate_hash, font_size: '10', font_name: 'name'}

  def generate_hash arg1, arg2 # has many arguments or no one 
    {
      "//COMPANY_NAME//": arg1.company_name,
      "//COMPANY_FULL_ADDRESS//": arg1.company_full_address,
      "//COMPANY_USER_POST//": arg1.company_user_post,
      "//SALARY//": arg2.salary,
      "//CURRENCY//": arg2.currency
    }
  end

end
```

**models_controller.rb**
```ruby
class ModelsController < ApplicationController

  def update
    @pdf = @model.generate_pdf params, [args] # params[:model][:field]  ;  args = ([arg1, arg2] || nil)
    render 'preview.pdf' and return if params[:preview]
    super
  end

  def create
    @pdf = @model.generate_pdf params, [args] # params[:model][:field]  ;  args = ([arg1, arg2] || nil)
    render 'preview.pdf' and return if params[:preview]
    super
  end

end
```

**views/preview.pdf.prawn**
```ruby
@pdf
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
