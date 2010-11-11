require 'gruff'

class Gruff::AbstractSar

  def initialize(filename, title, size = 800, font_size = 12)
    load_file(filename)
    @graph = graph_style.new size
    @graph.title = title
    @graph.x_axis_label = "Time"
    @graph.marker_font_size = font_size
    @graph.marker_count = 7

    @cols = []
    @col_values = []
    @labels = {}
  end

  def marker_count=(count)
    @graph.marker_count = count
  end

  def graph_style
    Gruff::Line
  end

  def load_file(filename)
    file = File.open(filename)
    @lines = file.readlines
    file.close
  end

  def header_re
    /re/
  end

  def line_re
    /re/
  end

  def exclude_re
    /re/
  end


  def calc(reverse = false, step = 6)
    label_index = 0
    @lines.each do |l|
      if l =~ exclude_re
        next
      end

      header_calc(l)

      value_calc(l)
    end


    output_labels = {}
    if @col_values[0].size >= 24
      (0..@col_values[0].size-1).step((@col_values[0].size-1)/6) do |i|
        output_labels.merge!(i => @labels[i])
      end
    else
      output_labels = @labels
    end

    if reverse
      index_range = (0..@cols.size-1).to_a.reverse
    else
      index_range = (0..@cols.size-1).to_a
    end
    index_range.each do |i|
      @graph.data(@cols[i], @col_values[i])
    end

    @graph.labels = output_labels
  end

  def header_calc(line)
    if @cols.empty? and line =~ header_re
      @cols = Regexp.last_match.to_a[2..-1]
      @cols.each do |c|
        c.gsub!(/%/, "\\%")
      end
    end
  end

  def value_calc(line)
    if line =~ line_re
      values = Regexp.last_match
      @cols.size.times do |i|
        @col_values[i] ||= []
        value = values[i+2]
        value.index(".") ? value = value.to_f : value = value.to_i
        @col_values[i].push(value)
      end

      @labels.merge!(@col_values[0].size-1 => $1)
    end
  end

  def write(output, min = nil, max = nil)
    @graph.minimum_value = min ? min : 0
    @graph.maximum_value = max if max

    @graph.write(output)
  end

end
