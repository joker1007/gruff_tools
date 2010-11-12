
class Gruff::NicstatByte < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+Int[\s\t]+(rKB\/s)[\s\t]+(wKB\/s)[\s\t]+rPk\/s[\s\t]+wPk\/s[\s\t]+rAvs[\s\t]+wAvs[\s\t]+%Util[\s\t]+Sat/
  end

  def line_re
    /(.*?)[\s\t]+#{@interface}[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, interface, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    @interface = interface
    @graph.y_axis_label = "KByte/s"
  end
end

class Gruff::NicstatPacket < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+Int[\s\t]+rKB\/s[\s\t]+wKB\/s[\s\t]+(rPk\/s)[\s\t]+(wPk\/s)[\s\t]+rAvs[\s\t]+wAvs[\s\t]+%Util[\s\t]+Sat/
  end

  def line_re
    /(.*?)[\s\t]+#{@interface}[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, interface, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    @interface = interface
    @graph.y_axis_label = "Packet Count"
  end
end

class Gruff::NicstatUsage < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+Int[\s\t]+rKB\/s[\s\t]+wKB\/s[\s\t]+rPk\/s[\s\t]+wPk\/s[\s\t]+rAvs[\s\t]+wAvs[\s\t]+(%Util)[\s\t]+Sat/
  end

  def line_re
    /(.*?)[\s\t]+#{@interface}[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+([\d\.]+)[\s\t]+[\d\.]+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, interface, title, size = 800, font_size = 12)
    super(file, title, size, font_size)
    @interface = interface
    @graph.y_axis_label = "Packet Count"
    @graph.marker_count = 10
  end

  def write(output, min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end

end
