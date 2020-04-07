# read _header.html, _body.html, _footer.html, _sidebar.html
# inject content
require 'erb'
require 'redcarpet'

class MfwGen
  #include ERB::util
  attr_accessor :template, :title

  def initialize()
    @markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, extensions = {}
    )
    @template = File.read('body.erb.html')
  end

  def to_html(md)
    @markdown.render(md)
  end

  def render()
    ERB.new(@template).result_with_hash({
      :title => 'Hello World!',
      :posts => [
        {
          :title => 'Ruby',
          :content => to_html("I'm _really getting used_ to **Ruby**!")
        },
        {
          :title => 'Rails',
          :content => to_html("Let's try some `inline code`.")
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
