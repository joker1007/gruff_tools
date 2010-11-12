# coding: utf-8
require "rubygems"
require "rspec"

$LOAD_PATH.push (File.dirname(__FILE__) + "/../lib")

require "gruff/gruff_tool"

describe Gruff::SarU do
  before do
    @header_line = "01:00:00    %usr    %sys    %wio   %idle"
    @value_line = "01:08:00       3       2       0      95"
    @value_line2 = "01:08:00       4       2       1      95"
  end

  it ".header_reがsar -uのヘッダ行にマッチすること" do
    sar_u = Gruff::SarU.new("dummy", "sar -u")
    (@header_line =~ sar_u.header_re).should be_true
  end

  it ".line_reがsar -uのデータ行にマッチすること" do
    sar_u = Gruff::SarU.new("dummy", "sar -u")
    (@value_line =~ sar_u.line_re).should be_true
  end

  it "#header_calcがsar -uのヘッダカラムの配列をインスタンス変数colsに格納すること" do
    sar_u = Gruff::SarU.new("dummy", "sar -u")
    sar_u.header_calc(@header_line)
    sar_u.instance_variable_get(:@cols).should == ["\\%usr", "\\%sys", "\\%wio", "\\%idle"]
  end

  it "#value_calcがsar -uデータ行の値と配列をインスタンス変数col_valuesに格納すること" do
    sar_u = Gruff::SarU.new("dummy", "sar -u")
    sar_u.header_calc(@header_line)
    sar_u.value_calc(@value_line)
    sar_u.instance_variable_get(:@col_values).should == [[3], [2], [0], [95]]
    sar_u.value_calc(@value_line2)
    sar_u.instance_variable_get(:@col_values).should == [[3, 4], [2, 2], [0, 1], [95, 95]]
  end

end

