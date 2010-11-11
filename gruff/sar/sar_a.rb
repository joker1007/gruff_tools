require "gruff/sar/abstract_sar"

class Gruff::SarA < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+(iget\/s)[\s\t]+(namei\/s)[\s\t]+(dirbk\/s)/
  end

  def line_re
    /(.*?)[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+(\d+)/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Count"
  end
end

