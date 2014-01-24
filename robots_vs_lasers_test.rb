require 'minitest/autorun'
require 'minitest/pride'
require_relative 'robots_vs_lasers'

# tests for Puzzle Node #4, Robots Vs. Lasers solution
class ConveyorTest < MiniTest::Unit::TestCase
  def setup
    @conveyor = Conveyor.new('#|#|#|##',  '---X----',  '###||###')
  end

  def test_least_damage_direction
    assert_equal @conveyor.least_damage_direction, :west
  end

  def test_most_damage_direction
    assert_equal @conveyor.most_damage_direction, :east
  end
end

class SchematicTest < MiniTest::Unit::TestCase
  def setup
    @schematic = Schematic.new('sample-input.txt')
  end

  def test_read_schematics
    File.open('sample-input.txt', 'r') do |test_file|
      line_array = test_file.readlines.reject { |line| line =~ /^\s*$/ }
      line_array.each_with_index do |line, index|
        assert_equal @schematic.schematics[index], line
      end
    end
  end

  def test_make_conveyors
    @schematic.conveyor_array.each { |conveyor| assert_kind_of Conveyor, conveyor }
  end

  def test_print_least_damage_direction
    assert_output("GO WEST\nGO EAST\nGO WEST\n") { @schematic.print_least_damage_direction }
  end
end
