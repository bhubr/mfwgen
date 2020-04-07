require 'yaml'
require 'mustache'
require 'redcarpet'

# https://stackoverflow.com/q/596216/#answer-56678483
def contrast_color(r, g, b)
  lum = (0.299 * r + 0.587 * g + 0.114 * b) / 255
  puts "#{r}, #{g}, #{b} >> #{lum}"
  if lum > 0.5
    return "#000"
  end
  "#fff"
end

def color_to_rgb(hex)
  r = hex[1..2].hex
  g = hex[3..4].hex
  b = hex[5..6].hex
  # contrast_color(r, g, b)
  [r, g, b]
end

def rgb_to_decimal(r, g, b)
  [r / 255.0, g / 255.0, b / 255.0]
end

def s_rgb_to_lin(color_channel)
  if color_channel <= 0.04045
    return color_channel / 12.92
  end
  ((color_channel + 0.055) / 1.055) ** 2.4
end

def y_to_l_star(y)
  return y < 216.0 / 24389 ? y ** (24389.0 / 27) : (y ** (1.0 / 3)) * 116 - 16
end

def get_fg_color(bg_hex)
  r, g, b = color_to_rgb(bg_hex)
  vr, vg, vb = rgb_to_decimal(r, g, b)
  # print "#{r}/#{vr}, #{g}/#{vg}, #{b}/#{vb}"
  luminance = 0.2126 * s_rgb_to_lin(vr) + 0.7152 * s_rgb_to_lin(vg) + 0.0722 * s_rgb_to_lin(vb)
  l_star = y_to_l_star(luminance)
  # puts "#{bg_hex} #{l_star}"
  l_star >= 50 ? '#000' : '#fff'
end

class MfwGen < Mustache
  # include ViewHelpers
  attr_accessor :template, :title

  self.template_path = __dir__
  def initialize()
    @markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, extensions = {}
    )
    @template = File.read('template.mustache.html')
    @palette = read_palette
  end

  def read_palette
    palette_yaml = File.read('palette.yml')
    palette_in = YAML.load(palette_yaml)
    palette = {}
    css = ""
    palette_in.each do |key, bg_color|
      fg_color = get_fg_color(bg_color)
      palette[key] = {
        :fg => fg_color,
        :bg => bg_color
      }

      css += ".tag-#{key} { color: #{fg_color}; background: #{bg_color}; }\n"
    end
    open('tags.css', 'w') do |f|
      f << css
    end
    palette
  end

  def to_html(md)
    @markdown.render(md)
  end

  def parse_front_matter(fm)
    hash = {}
    fm_lines = fm.split('\n')
    fm_lines.each do |line|
      bits = line.split(': ')
      k = bits[0]
      v = bits[1]
      if k != 'tags'
        hash[k] = v
      else
        hash[k] = v.split(',')
      end
    end
    hash
  end

  def render()
    posts = [
      {
        :title => 'Ruby',
        :content => to_html("I'm _really getting used_ to **Ruby**!"),
        :front_matter => 'title: Ruby\ndescription: A random post on Ruby\ntags: ruby\ndate: 2020-04-06'
      },
      {
        :title => 'Rails',
        :content => to_html("Let's try some `inline code`."),
        :front_matter => 'title: Rails\ndescription: A random post on Ruby-on-Rails\ntags: ruby,ruby-on-rails\ndate: 2020-04-07'
      },
      {
        :title => 'Monkey in Go&Ruby',
        :content => to_html("Let's try some `inline code`."),
        :front_matter => 'title: Rails&Go\ndescription: Anothe random post on Ruby-on-Rails\ntags: go,ruby,ruby-on-rails,js\ndate: 2020-04-07'
      }
    ]
    posts.each do |post|
      parsed_fm = parse_front_matter(post[:front_matter])
      post[:meta] = parsed_fm
    end
    view = {
      :title => 'Hello World!',
      :posts => posts
    }
    Mustache.render(@template, view)
  end
end


# header = File.read('header.erb.html')
# erb_header = ERB.new(header)
# erb_body = ERB.new(body)

# puts erb_body.

gen = MfwGen.new()
puts gen.render 
