require_relative  'game'
require_relative  'helper'



def test_piece
  map = Map.new

  rr_lines = [
    ["0 4 0 3 3 3 1 1 1 3 3"],
    ["0 7 4 4 3 5 4 5 6 4 3"],
  ]
  

  rr_lines[-1..-1].each do |line|

    map.rr=line[0].split(' ').map{|x| x.to_i}

    arr = "LJOLZJOZ"
    ss=arr.size

    for i in 0..ss-1

      p "-----round #{i+1}"
      curr_pt = arr[i]
      next_pt = arr[i+1]

      best_pos = BlackBox.anlz(map, curr_pt,true)
      prev_rr = map.rr.clone

      p "curr=#{curr_pt} next=#{next_pt} best_pos=#{best_pos}"

      Bot.set_piece(map, curr_pt, best_pos)

      show_field_h(map,prev_rr)
      #clean_lines(map)
    end
  end
end

test_piece
