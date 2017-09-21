# ActsAsPdf

Quick way to convert markdown to a template pdf. 

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

## Usage

**bill.rb**
```ruby
class Bill < ApplicationRecord

  acts_as_pdf :field, {method: :generate_bill, font_size: '10', font_name: 'Arial', line_height: '180%'}

  def generate_bill user, company, obj # has many arguments or no one 
    {
      "//COMPANY_NAME//": company.company_name,
      "//COMPANY_FULL_ADDRESS//": company.company_full_address,
      "//COMPANY_USER_POST//": company.company_user_post,
      "//USER_FIRST_NAME//": user.first_name,
      "//USER_LAST_NAME//": user.last_name,
      "//OBJECT_PRICE//": obj.salary,
      "//OBJECT_CURRENCY//": obj.currency
    }
  end

end
```

**bills_controller.rb**
```ruby
class BillsController < ApplicationController
  preview_pdf
  # preview_pdf {view: 'preview.pdf'}
end
```

**views/bills/preview.pdf.prawn**
```ruby
@pdf
```

**views/bills/_form.html.haml**
```ruby
= simple_form_for resource do |f|
    = f.text :field # with the markdown gem you want (be aware of whitespaces)
    = f.submit 'preview', name: 'preview',  action: 'preview', formtarget: "_blank", id: "first"
    = f.submit class: 'btn btn-custom inline', id: "second"

:javascript # in other file
  $('#first').removeAttr('data-disable-with')
  $('#second').removeAttr('data-disable-with')

```

**routes.rb**
```ruby
    resources :bills do
      post :create, on: :member, action: :preview
      patch :update, on: :member, action: :preview
    end
```

Now you can use it at runtime:

**users_controller.rb**
```ruby
class BillsController < ApplicationController

  def after_buying_something
    bill = Bill.find(param[:bill_id])
    product = Product.find(param[:product_id])
    @pdf = bill.generate_bill(@user, product.company, product)
  end
end
```

**views/bills/after_buying_something.pdf.prawn**
```ruby
@pdf
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
