require_relative  'game'
require_relative  'helper'



def test_piece
  map = Map.new

  rr_lines = [
    "0 8 8 9 6 8 8 8 7 6 6",
    "0 8 8 9 9 8 8 5 8 8 10",
    "0 1 4 4 2 3 4 4 4 2 0",
  ]


  rr_lines.each do |line|
    p "--------line #{line}"
    map.rr=line.split(' ').map{|x| x.to_i}

    arr = "TOIT"
    ss=arr.size

    for i in 0..3

      p "***round #{i+1}"
      curr_p = arr[i]
      next_p = arr[i+1]
      break if next_p.nil?
      prev_rr = map.rr.clone

      Bot.make_test_turn(map, curr_p, next_p)

      show_field_h(map,prev_rr)

    end
  end
end
test_piece
