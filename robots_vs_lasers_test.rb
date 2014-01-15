require 'minitest/autorun'
require 'minitest/pride'
require_relative 'robots_vs_lasers'

# tests for Puzzle Node #4, Robots Vs. Lasers solution
class ConveyorTest < MiniTest::Unit::TestCase
  def setup
    @conveyor = Conveyor.new('#|#|#|##',  '---X----',  '###||###')
  end

  def test_conveyor_exists
    refute @conveyor.nil?
  end

  def test_correct_answer_from_robots_goes?
    assert_equal @conveyor.robot_goes?, :west
  end

  def teardown
    @conveyor = nil
  end
end

class SchematicTest < MiniTest::Unit::TestCase
  def setup
    @schematic = Schematic.new('sample-input.txt')
  end

  def test_schematic_exists
    refute @schematic.nil?
  end

  def test_read_schematics
    File.open('single-schematic.txt', 'r') do |test_file|
      assert_equal @schematic.schematics[0], test_file.gets
    end
  end

  def test_make_conveyors
    @schematic.conveyor_array.each { |conveyor| assert_kind_of Conveyor, conveyor }
  end

  def test_print_conveyer_solutions
    assert_output("GO WEST\nGO EAST\nGO WEST\n") { @schematic.print_conveyor_solutions }
  end

  def teardown
    @schematic = nil
  end
end
