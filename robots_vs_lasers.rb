# solution for Puzzle Node #4, Robots Vs. Lasers
# practicing Ruby for Codernight
class Conveyor
  def initialize(line_1, line_2, line_3)
    @north_lasers = convert_laser_position(line_1)
    @robot_position = convert_robot_position(line_2)
    @south_lasers = convert_laser_position(line_3)
    @width = line_1.length
    @west_range = @robot_position.downto(0)
    @east_range = (@robot_position..@width)
  end

  def least_damage_direction
    damage(@west_range) <= damage(@east_range) ? :west : :east
  end

  def most_damage_direction
    damage(@west_range) >= damage(@east_range) ? :west : :east
  end

  private

  # str --> index
  def convert_robot_position(position_string)
    position_string.chars.index('X')
  end

  # str --> char arr
  def convert_laser_position(position_string)
    position_string.chomp.chars
  end

  # find damage of robot over range of conveyor
  def damage(range)
    range.each.with_index.inject(0) do |damage,(n,step)|
      if @north_lasers[n] == '|' and step.even?
        damage + 1
      elsif @south_lasers[n] == '|' and step.odd?
        damage + 1
      else
        damage
      end
    end
  end
end

class Schematic
  attr_accessor :schematics, :conveyor_array

  def initialize(file)
    read_schematics(file)
    make_conveyors
  end

  # TODO: this is a crappy method name and idea, not intuitive, rethink this
  def print_least_damage_direction
    conveyor_array.each do |conveyor|
      puts 'GO WEST' if conveyor.least_damage_direction == :west
      puts 'GO EAST' if conveyor.least_damage_direction == :east
    end
  end

  private

  # makes string array of lines from file, rejecting blank lines
  def read_schematics(file)
    File.open(file, 'r') do |file|
      @schematics = file.readlines.reject { |line| line =~ /^\s*$/ }
    end
  end

  # create conveyors with each group of 3 lines as attributes
  def make_conveyors
    (2..@schematics.length-1).step(3) do |n|
      (@conveyor_array ||= []) << Conveyor.new(@schematics[n-2],
                                               @schematics[n-1],
                                               @schematics[n])
    end
  end
end
