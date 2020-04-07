# read _header.html, _body.html, _footer.html, _sidebar.html
# inject content
require 'mustache'
require 'redcarpet'

# module ViewHelpers
#   def tags
#     p self
#     self[:front_matter]
#   end
# end

class MfwGen < Mustache
  # include ViewHelpers
  attr_accessor :template, :title

  self.template_path = __dir__
  def initialize()
    @markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, extensions = {}
    )
    @template = File.read('template.mustache.html')
  end

  def to_html(md)
    @markdown.render(md)
  end

  def render()
    Mustache.render(@template, {
      :title => 'Hello World!',
      :posts => [
        {
          :title => 'Ruby',
          :content => to_html("I'm _really getting used_ to **Ruby**!"),
          :front_matter => 'title: Ruby\ndescription: A random post on Ruby\ntags: ruby\ndate: 2020-04-06'
        },
        {
          :title => 'Rails',
          :content => to_html("Let's try some `inline code`."),
          :front_matter => 'title: Rails\ndescription: A random post on Ruby-on-Rails\ntags: ruby,ruby-on-rails\ndate: 2020-04-07'
        }
      ]
    })
  end
end


# header = File.read('header.erb.html')
# erb_header = ERB.new(header)
# erb_body = ERB.new(body)

# puts erb_body.

gen = MfwGen.new()
puts gen.render 
