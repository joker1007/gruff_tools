
class Gruff::SarW1 < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+(swpin\/s)[\s\t]+(bswin\/s)[\s\t]+(swpot\/s)[\s\t]+bswot\/s[\s\t]+pswch\/s/
  end

  def line_re
    /(.*?)[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+([\d\.]+)[\s\t]+[\d\.]+[\s\t]+\d+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Process Count"
  end
end

class Gruff::SarW2 < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+swpin\/s[\s\t]+bswin\/s[\s\t]+swpot\/s[\s\t]+(bswot\/s)[\s\t]+pswch\/s/
  end

  def line_re
    /(.*?)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+([\d\.]+)[\s\t]+\d+/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Block Count"
  end
end

class Gruff::SarW3 < Gruff::AbstractSar
  def header_re
    /(.*?)[\s\t]+swpin\/s[\s\t]+bswin\/s[\s\t]+swpot\/s[\s\t]+bswot\/s[\s\t]+(pswch\/s)/
  end

  def line_re
    /(.*?)[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+(\d+)/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Context Switch Count"
  end

end

