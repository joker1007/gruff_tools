
class Gruff::VmstatFreeMemory < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+r[\s\t]+b[\s\t]+w[\s\t]+(swap)[\s\t]+(free)[\s\t]+re[\s\t]+mf[\s\t]+pi[\s\t]+po[\s\t]+fr[\s\t]+de[\s\t]+sr[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+in[\s\t]+sy[\s\t]+cs[\s\t]+us[\s\t]+sy[\s\t]+id/
  end

  def line_re
    /(.*?)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+/
  end

  def exclude_re
    /^Average/
  end

  def value_calc(line)
    if line =~ line_re
      values = Regexp.last_match
      @cols.size.times do |i|
        @col_values[i] ||= []
        value = values[i+2]
        value.index(".") ? value = value.to_f : value = value.to_i
        value = value / 1024
        @col_values[i].push(value)
      end

      @labels.merge!(@col_values[0].size-1 => $1)
    end
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "MByte"
  end
end

class Gruff::VmstatPage1 < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+r[\s\t]+b[\s\t]+w[\s\t]+swap[\s\t]+free[\s\t]+re[\s\t]+mf[\s\t]+(pi)[\s\t]+(po)[\s\t]+(fr)[\s\t]+(de)[\s\t]+sr[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+in[\s\t]+sy[\s\t]+cs[\s\t]+us[\s\t]+sy[\s\t]+id/
  end

  def line_re
    /(.*?)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "KByte"
  end
end

class Gruff::VmstatPage2 < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+r[\s\t]+b[\s\t]+w[\s\t]+swap[\s\t]+free[\s\t]+(re)[\s\t]+mf[\s\t]+pi[\s\t]+po[\s\t]+fr[\s\t]+de[\s\t]+(sr)[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+in[\s\t]+sy[\s\t]+cs[\s\t]+us[\s\t]+sy[\s\t]+id/
  end

  def line_re
    /(.*?)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+(\d+)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+(\d+)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Page Count"
  end
end

class Gruff::VmstatCpu < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+r[\s\t]+b[\s\t]+w[\s\t]+swap[\s\t]+free[\s\t]+re[\s\t]+mf[\s\t]+pi[\s\t]+po[\s\t]+fr[\s\t]+de[\s\t]+sr[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+.*?[\s\t]+in[\s\t]+sy[\s\t]+cs[\s\t]+(us)[\s\t]+(sy)[\s\t]+(id)/
  end

  def line_re
    /(.*?)[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+\d+[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+(\d+)/
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
    @graph.marker_count = 10
    @graph.last_series_goes_on_bottom = true
  end

  def write(output, min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end

  def to_blob(min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end

end
