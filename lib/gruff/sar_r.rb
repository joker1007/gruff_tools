
class Gruff::SarR < Gruff::AbstractSysstat
  def header_re
    /(.*?)[\s\t]+(freemem)[\s\t]+(freeswap)/
  end

  def line_re
    /(.*?)[\s\t]+(\d+)[\s\t]+(\d+)/
  end

  def exclude_re
    /^Average/
  end

  def initialize(file, title, size = 800, font_size = 12)
    super
    @graph.y_axis_label = "Mbytes"
    @graph.marker_count = 7
    @spark = true
  end

  def spark=(flag)
    @spark = flag
  end

  def spark?
    @spark
  end

  def value_calc(line)
    if line =~ line_re
      values = Regexp.last_match
      @cols.size.times do |i|
        @col_values[i] ||= []
        value = values[i+2]
        if i == 0
          value.index(".") ? value = value.to_f : value = value.to_i
          pagesize = spark? ? 8192 : 4096
          value = value * pagesize / 1024 / 1024
        else
          value.index(".") ? value = value.to_f : value = value.to_i
          value = value * 512 / 1024 / 1024
        end

        @col_values[i].push(value)
      end

      @labels.merge!(@col_values[0].size-1 => $1)
    end
  end


end

