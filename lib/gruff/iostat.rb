
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

  def to_blob(min = nil, max = nil)
    @graph.maximum_value = 100

    super
  end
end

class Gruff::IostatMultiDevice
  def device_re
    /.*?[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+[\d\.]+[\s\t]+\d+[\s\t]+\d+[\s\t]+(#{@device})$/
  end

  def initialize(filename, device)
    if filename.is_a?(String)
      load_file(filename)
    elsif filename.is_a?(IO) or filename.is_a?(Tempfile)
      @lines = filename.readlines
    end

    @device = device
    @devices = []
  end

  def load_file(filename)
    file = File.open(filename)
    body = file.read(1024*150)
    @lines = body.split(/\r?\n/)
    file.close
  end

  def get_devices
    if @devices.empty?
      count = 0
      @lines.each do |l|
        count += 1
        STDOUT.putc "." if count % 10 == 0
        STDOUT.puts count.to_s if count % 100 == 0
        if l =~ device_re
          @devices << $1
        end
      end
      @devices.uniq!
      @devices
    else
      @devices
    end
  end
end

