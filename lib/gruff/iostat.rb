
class Gruff::IostatCount < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+(r\/s)[\s\t]+(w\/s)[\s\t]+kr\/s[\s\t]+kw\/s[\s\t]+wait[\s\t]+actv[\s\t]+wsvc_t[\s\t]+asvc_t[\s\t]+%w[\s\t]+%b[\s\t]+device/
  end

  def line_re
    /(.*?)[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+\d+[\s\t]+\d+[\s\t]+#{@device}$/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, device, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    header = @lines[0..1]
    @lines.shift
    @lines.shift
    @lines = header + @lines.grep(/#{device}$/)
    @device = device
    @graph.y_axis_label = "Count"
  end
end

class Gruff::IostatByte < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+r\/s[\s\t]+w\/s[\s\t]+(kr\/s)[\s\t]+(kw\/s)[\s\t]+wait[\s\t]+actv[\s\t]+wsvc_t[\s\t]+asvc_t[\s\t]+%w[\s\t]+%b[\s\t]+device/
  end

  def line_re
    /(.*?)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+\d+[\s\t]+\d+[\s\t]+#{@device}$/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, device, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    header = @lines[0..1]
    @lines.shift
    @lines.shift
    @lines = header + @lines.grep(/#{device}$/)
    @device = device
    @graph.y_axis_label = "KByte"
  end
end

class Gruff::IostatWait < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+r\/s[\s\t]+w\/s[\s\t]+kr\/s[\s\t]+kw\/s[\s\t]+(wait)[\s\t]+(actv)[\s\t]+wsvc_t[\s\t]+asvc_t[\s\t]+%w[\s\t]+%b[\s\t]+device/
  end

  def line_re
    /(.*?)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+\d+[\s\t]+\d+[\s\t]+#{@device}$/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, device, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    header = @lines[0..1]
    @lines.shift
    @lines.shift
    @lines = header + @lines.grep(/#{device}$/)
    @device = device
    @graph.y_axis_label = "Average Transaction Count"
    @graph.marker_count = nil
  end
end


class Gruff::IostatBusy < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+r\/s[\s\t]+w\/s[\s\t]+kr\/s[\s\t]+kw\/s[\s\t]+wait[\s\t]+actv[\s\t]+wsvc_t[\s\t]+asvc_t[\s\t]+(%w)[\s\t]+(%b)[\s\t]+device/
  end

  def line_re
    /(.*?)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+(\d+)[\s\t]+(\d+)[\s\t]+#{@device}$/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, device, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    header = @lines[0..1]
    @lines.shift
    @lines.shift
    @lines = header + @lines.grep(/#{device}$/)
    @device = device
    @graph.y_axis_label = "Percent"
    @graph.marker_count = 10
  end

  def write(output, min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end
end
