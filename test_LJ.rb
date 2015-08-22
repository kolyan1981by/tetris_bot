require_relative  'game'
require_relative  'helper'



def test_piece
  map = Map.new

  rr_lines = [
    "0 4 4 4 3 5 5 5 3 1 3",
    "0 0 4 4 2 3 3 5 6 5 4",
  ]


  line = rr_lines[1]

  map.rr=line.split(' ').map{|x| x.to_i}

  arr = "LOO"
  ss=arr.size

  for i in 0..ss-1

    p "-----round #{i+1}"
    curr_p = arr[i]
    next_p = arr[i+1]
    break if next_p.nil?
    prev_rr = map.rr.clone
    Bot.make_test_turn(map, curr_p, next_p)

    show_field_h(map,prev_rr)

  end

end

test_piece
