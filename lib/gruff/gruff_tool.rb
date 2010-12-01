require 'rubygems'
require 'gruff'

module Gruff
  class Base
    def theme_japan
      # Colors
      @blue = '#003755'
      @yellow = '#C89637'
      @green = '#A5D75F'
      @red = '#C80000'
      @purple = '#5A2864'
      @orange = '#EFAA43'
      @white = 'black'
      @colors = [@yellow, @blue, @green, @red, @purple, @orange, @white]

      self.theme = {
        :colors => @colors,
        :marker_color => 'black',
        :font_color => 'black',
        :background_colors => ['#D0D0D0', '#F0F0F0']
      }
    end

    def theme_letoro
      # Colors
      @blue = '#8CAAC8'
      @yellow = '#FFB428'
      @gray = '#BEC3BE'
      @red = '#C80000'
      @purple = '#5A2864'
      @orange = '#EFAA43'
      @white = 'white'
      @colors = [@blue, @gray, @red, @white, @yellow, @purple, @orange]

      self.theme = {
        :colors => @colors,
        :marker_color => 'white',
        :font_color => 'white',
        :background_colors => ['#694B28', '#695A14']
      }
    end
  end
end


module Gruff
  autoload :AbstractSysstat, 'lib/gruff/abstract_sysstat'
  autoload :IostatCount, 'lib/gruff/iostat'
  autoload :IostatByte, 'lib/gruff/iostat'
  autoload :IostatWait, 'lib/gruff/iostat'
  autoload :IostatBusy, 'lib/gruff/iostat'
  autoload :IostatMultiDevice, 'lib/gruff/iostat'
  autoload :SarR, 'lib/gruff/sar_r'
  autoload :SarW1, 'lib/gruff/sar_w'
  autoload :SarW2, 'lib/gruff/sar_w'
  autoload :SarW3, 'lib/gruff/sar_w'
  autoload :SarA, 'lib/gruff/sar_a'
  autoload :SarQ1, 'lib/gruff/sar_q'
  autoload :SarQ2, 'lib/gruff/sar_q'
  autoload :SarU, 'lib/gruff/sar_u'
  autoload :Vmstat, 'lib/gruff/vmstat'
  autoload :VmstatFreeMemory, 'lib/gruff/vmstat'
  autoload :VmstatPage1, 'lib/gruff/vmstat'
  autoload :VmstatPage2, 'lib/gruff/vmstat'
  autoload :VmstatCpu, 'lib/gruff/vmstat'
  autoload :NicstatByte, 'lib/gruff/nicstat'
  autoload :NicstatPacket, 'lib/gruff/nicstat'
  autoload :NicstatUsage, 'lib/gruff/nicstat'
end

