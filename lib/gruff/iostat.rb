
class Gruff::IostatCount < Gruff::AbstractSysstat
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

class Gruff::IostatByte < Gruff::AbstractSysstat
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

class Gruff::IostatWait < Gruff::AbstractSysstat
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


class Gruff::IostatBusy < Gruff::AbstractSysstat
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

  def to_blob(format = "PNG", min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end
end

class Gruff::IostatMultiDevice
  def header_re
    /.*?[\s\t]+r\/s[\s\t]+w\/s[\s\t]+kr\/s[\s\t]+kw\/s[\s\t]+wait[\s\t]+actv[\s\t]+wsvc_t[\s\t]+asvc_t[\s\t]+%w[\s\t]+%b[\s\t]+device/
  end

  def device_re
    /.*?[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+\d+[\s\t]+\d+[\s\t]+(#{@device})$/
  end

  def initialize(filename, device)
    if filename.is_a?(String)
      @input = File.open(filename)
    elsif filename.is_a?(IO) or filename.is_a?(Tempfile)
      @input = filename
    end

    @device = device
    @devices = []
  end

  def get_devices
    parse_flag = false
    if @devices.empty?
      until @input.eof?
        line = @input.readline.chomp

        if parse_flag == true and line =~ header_re
          break
        end

        if parse_flag == false and line =~ header_re
          parse_flag = true
        end

        if line =~ device_re
          @devices << $1
        end
      end
      @devices.uniq!
    end
    @devices
  end
end

