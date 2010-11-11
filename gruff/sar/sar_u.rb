require "gruff/sar/abstract_sar"

class Gruff::SarU < Gruff::AbstractSar

  def header_re
    /(.*?)[\s\t]+(\%usr)[\s\t]+(\%sys)[\s\t]+(\%wio)[\s\t]+(\%idle)/
  end

  def line_re
    /(.*?)[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+(\d+)/
  end

  def exclude_re
    /^Average/
  end

  def graph_style
    Gruff::StackedArea
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Percent"
    @graph.last_series_goes_on_bottom = true
  end

  def write(output, min = nil, max = nil)
    @graph.minimum_value = min if min
    @graph.maximum_value = max ? max : 100

    @graph.write(output)
  end

end
