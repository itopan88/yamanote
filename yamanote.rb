#! ruby -EUTF-8
# coding: UTF-8

require 'curses'

class Yamanote 

  include Curses

  @@speed = 0.05 

  # define yamanote line AA 
  def yamanote_lines
    [
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

  def run

    init_screen
    
    # get max length of AA
    aa_length = 0 
    yamanote_lines.each {|e|
      aa_length = e.length if e.length > aa_length
    }

    # print
    (cols - aa_length).step(0, -1) do |x|
      yamanote_lines.each_with_index do |line, y|
        setpos(y + (lines / 2) - (yamanote_lines.length / 2) , x)
        stdscr << line
      end
      refresh
      sleep(@@speed)
    end

    close_screen

  end

end

# main 
if __FILE__ == $0
  Yamanote.new.run
end
