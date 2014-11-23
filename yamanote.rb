#! ruby -EUTF-8
# coding: UTF-8
require 'curses'
require 'optparse'


class AsciiArts

  def yamanote_lines
    return [
      "                   ____________                ",
      "  ________________/_|________|_\\_____________ ",
      "γ　　　　　　　　　　　　　　　　　　　　　  \\ ",
      "|========================○=========[山手線]==| ",
      "|￣ヽ   _    _____    _______       _____    | ",
      "|   |  |□|  |  |  |  |_______|     |  |  |   | ",
      "|   |──| |──|  |  |────────────────|  |  |───| ",
      "|   |──|_|──|  |  |────────────────|  |  |───| ",
      "|__ ﾉ　JR   |__|__|                |__|__|   | ",
      "|____________________________________________| ",
      "|______|OO|*****|OO|*****|OO|*****|OO|*******| ",
      "       \\OO/     \\OO/     \\OO/     \\OO/     ",
    ]
  end

  def yamanote_lines_little
    return [
      "             ____            ",
      " ___________/|__|\\_______   ",
      "γ_ 　　　　　　　　  　   \\ ",
      "| | □==========○=[大崎]===|  ",
      "| | ───||─────────||──────|  ",
      "|_| JR─||─────────||──────|  ",
      "|________________________ |  ",
      "|O|*|O|*|O|*|O|*|O|*|O|*|O|  ",
    ]
  end

  def yamanote_lines_little_joint
    return [
      "             ____                         ____            ",
      " ___________/|__|\\_______     ___________/|__|\\_______   ",
      "γ_ 　　　　　　　　  　   \\  γ_ 　　　　　　　　  　   \\ ",
      "| | □==========○=[大崎]===|  | | □==========○==========|  ",
      "| | ───||─────────||──────|**| | ───||─────────||──────|* ",
      "|_| JR─||─────────||──────|**|_| JR─||─────────||──────|* ",
      "|________________________ |  |________________________ |  ",
      "|O|*|O|*|O|*|O|*|O|*|O|*|O|  |O|*|O|*|O|*|O|*|O|*|O|*|O|  ",
    ]
  end

  def yamanote_routemap
    return [
      "　    < 内回り         ",
      "　      外回り >       ",
      "---------------------- ",
      "      巣鴨 駒込        ",
      "   大塚      田端      ",
      "   池袋      西日暮里  ",
      "   目白      日暮里    ",
      "   高田馬場  鶯谷      ",
      "   新大久保  上野      ",
      "   新宿      御徒町    ",
      "   代々木    秋葉原    ",
      "   原宿      神田      ",
      "   渋谷      東京      ",
      "   恵比寿    有楽町    ",
      "   目黒      新橋      ",
      "   五反田    浜松町    ",
      "      大崎  田町       ",
      "         品川          ",
      "---------------------- ",
    ]
  end

end


class Runner 

  include Curses
  @@speed = 0.04 #default speed 

  def setspeed(speed)
    @@speed = speed 
  end

  def run(aa_lines)
    init_screen
    aa_length = 0 
    aa_lines.each {|e|
      aa_length = e.length if e.length > aa_length
    }
    (cols - aa_length).step(0, -1) do |x|
      aa_lines.each_with_index do |line, y|
        setpos(y + (lines / 2) - (aa_lines.length / 2) , x)
        stdscr << line
      end
      refresh
      sleep(@@speed)
    end
    close_screen
  end

  def display(aa_lines)
    init_screen 
    aa_length = 0 
    aa_lines.each {|e|
      aa_length = e.length if e.length > aa_length
    }
    aa_lines.each_with_index do |line, y|
      setpos(y + (lines / 2) - (aa_lines.length / 2) , (cols / 2) - (aa_length/2) )
      stdscr << line
    end
    refresh
    getch
    close_screen
  end

end


# main
if __FILE__ == $0

  runner = Runner.new
  asciiarts = AsciiArts.new
  aa_lines = asciiarts.yamanote_lines 

  # do parse options
  option={}
  OptionParser.new do |opt|
    opt.on('-l','runs a little yamanote'){|v| option[:l] = v}
    opt.on('-j','runs little joint yamanote'){|v| option[:j] = v}
    opt.on('-s VALUE','specify the running speed:VALUE = "exfast" or "fast" or "normal" or "slow"'){|v| option[:s] = v}
    opt.on('-m','show yamanote routemap'){|v| option[:m] = v}
    opt.parse!(ARGV)
  end

  if option[:l] then
    aa_lines = asciiarts.yamanote_lines_little 
  end
  
  if option[:j] then
    aa_lines = asciiarts.new.yamanote_lines_little_joint 
  end
  
  if option[:m] then
    runner.display(asciiarts.new.yamanote_routemap)
    exit 0
  end
  
  if option[:s] then
    case option[:s] 
      when "exfast" then runner.setspeed(0.005)
      when "fast"   then runner.setspeed(0.02)
      when "normal" then runner.setspeed(0.04)
      when "slow"   then runner.setspeed(0.08)
    end
  end

  #go 
  runner.run(aa_lines)

end
