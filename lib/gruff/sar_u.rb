
class Gruff::SarU < Gruff::AbstractSysstat

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
    @graph.marker_count = 10
  end

  def write(output, min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end

  def to_blob(format = "png", min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end

end
