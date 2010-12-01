
class Gruff::SarQ1 < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+(runq-sz)[\s\t]+\%runocc[\s\t]+(swpq-sz)[\s\t]+\%swpocc/
  end

  def line_re
    /(.*?)[\s\t]+([\d\.]+)[\s\t]+\d+[\s\t]+([\d\.]+)[\s\t]+\d+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Queue Count"
  end
end

class Gruff::SarQ2 < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+runq-sz[\s\t]+(\%runocc)[\s\t]+swpq-sz[\s\t]+(\%swpocc)/
  end

  def line_re
    /(.*?)[\s\t]+[\d\.]+[\s\t]+(\d+)[\s\t]+[\d\.]+[\s\t]+(\d+)/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Percent"
  end
end
