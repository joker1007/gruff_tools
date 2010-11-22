module Gruff
  class Base

    protected
    def draw_axis_labels
      unless @x_axis_label.nil?
        # X Axis
        # Centered vertically and horizontally by setting the
        # height to 1.0 and the width to the width of the graph.
        x_axis_label_y_coordinate = @raw_rows - 10.0 - @marker_caps_height

        # TODO Center between graph area
        @d.fill = @font_color
        @d.font = @font if @font
        @d.stroke('transparent')
        @d.pointsize = scale_fontsize(@marker_font_size)
        @d.gravity = NorthGravity
        @d = @d.annotate_scaled( @base_image,
                                 @raw_columns, 1.0,
                                 0.0, x_axis_label_y_coordinate,
                                 @x_axis_label, @scale)
        debug { @d.line 0.0, x_axis_label_y_coordinate, @raw_columns, x_axis_label_y_coordinate }
      end

      unless @y_axis_label.nil?
        # Y Axis, rotated vertically
        @d.rotation = 90.0
        @d.gravity = CenterGravity
        @d = @d.annotate_scaled( @base_image,
                                 1.0, @raw_rows,
                                 @left_margin + @marker_caps_height / 2.0, 0.0,
                                 @y_axis_label, @scale)
        @d.rotation = -90.0
      end
    end

    def draw_label(x_offset, index)
      return if @hide_line_markers

      if !@labels[index].nil? && @labels_seen[index].nil?
        x_offset = x_offset - calculate_width(@marker_font_size, @labels[index]) / 2.0
        @d.rotation = -90.0
        y_offset = @graph_bottom - LABEL_MARGIN * 2

        @d.fill = @font_color
        @d.font = @font if @font
        @d.stroke('transparent')
        @d.font_weight = NormalWeight
        @d.pointsize = scale_fontsize(@marker_font_size)
        @d.gravity = WestGravity
        @d = @d.annotate_scaled(@base_image,
                                1.0, 1.0,
                                x_offset, y_offset,
                                @labels[index], @scale)
        @labels_seen[index] = 1
        @d.rotation = 90.0
        debug { @d.line 0.0, y_offset, @raw_columns, y_offset }
      end
    end
  end
end

