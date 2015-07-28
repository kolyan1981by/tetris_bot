
def set_settings(arr,stt)
  case arr[1]
  when "timebank"; stt.timebank = arr[2].to_i
  when "time_per_move"; stt.time_per_move = arr[2].to_i
  when "your_bot"; stt.your_bot = arr[2]
  when "field_height"; stt.field_height = arr[2].to_i
  when "field_width"; stt.field_width = arr[2].to_i
  end
end

def update_game(arr,gg)

  case arr[2]
  when "round"; gg.round = arr[3].to_i
  when "this_piece_type"; gg.this_piece_type = arr[3].strip
  when "next_piece_type"; gg.next_piece_type = arr[3].strip
  when "this_piece_position";

  end
end

def update_player(arr,plr)

  case arr[2]
  when "row_points"; plr.row_points = arr[3].to_i
  when "combo"; plr.combo = arr[3].to_i
  when "field"; plr.field = arr[3]
  end
end

#######


def check_gaps(map, ptype)
  gg = map.gaps
  for i in 1..10
    if gg[i]!=0
      res = is_fill(map, i, ptype)
      return res unless res.nil?
    end
  end

  nil

end

def is_fill(map, pos, ptype)
  rr = map.rr
  gg =map.gaps
  i = pos
  res=[]

  #####right shifting
  if i>3 && fit_row_line(rr, i-3, ['0','0','0']) && rr[i-1] ==gg[i]-1

    if ptype=='J' ;
      rr[i-2]+=2;
      rr[i-1]+=1;
      gg[i]=0;
      return { orient: 1, level: rr[i-3], moves: ['right']}
    end

    #if ptype=='Z' ; rr[i-2]+=2;rr[i-1]+=1;gg[i]=0; end

  end

  if i>2 && rr[i-2] == rr[i-1] && rr[i-1] ==gg[i]-1

    if ptype=='L'
      rr[i-1]+=3; gg[i]=0;
      return { orient: 3, level: rr[i-2], moves: ['right']}
    end
  end

  ######left shifting
  if i<8 && fit_row_line(rr, i+1, ['0','0','0']) && rr[i+1] ==gg[i]-1

    if ptype=='L'
      gg[i]=0;rr[i+1]+=1;rr[i+2]+=2;
      return { orient: 0, level: rr[i+3], moves: ['left']};
    end

    if ptype=='S' ;
      gg[i]=0;rr[i+1]+=2;rr[i+2]+=2;gg[i+2]=rr[i+2]-1;
      return { orient: 0, level: rr[i+3], moves: ['left']}
    end

  end

  if i<9 && rr[i+2] == rr[i+1] && rr[i+1] ==gg[i]-1
    if ptype=='J'
      gg[i]=0;rr[i+1]+=3;
      return { orient: 1, level: rr[i+2], moves: ['left']};
    end
  end

end

def fit_row_line(rr,i,templ)
  res=[]
  for k in 0..templ.size-2
    return false if rr[i+k] - templ[k].to_i != rr[i+k+1] - templ[k+1].to_i
  end
  true
end

#############find best variant
def find_min_level(pos)
  min= pos.map{|el| el[2]}.min
  res= pos.find{|a| a[2] == min}

  if res.nil?

    pos.first
  else
    res
  end

end
def find_max_compatibility(pos)
  max= pos.map{|el| el[3]}.max
  res= pos.find{|a| a[3] == max}

  if res.nil?
    pos.first
  else
    res
  end

end

def load_rules(ptype)

  res = []

  file = case ptype
  when 'I'; "rules/rI.dt"
  when 'J'; "rules/rJ.dt"
  when 'L'; "rules/rL.dt"
  when 'O'; "rules/rO.dt"
  when 'S'; "rules/rS.dt"
  when 'Z'; "rules/rZ.dt"
  when 'T'; "rules/rT.dt"
  end

  File.open(file, "r").each do |line|
    next if /\S/ !~ line

    arr = line.split(":")
    res << [arr[0], arr[1].split(' ')]
  end
  res
end

def show_field(map)

  field = map.field
  row = map.rr

  p "Field 10x20"
  p "gaps: #{map.gaps}"

  for i in 1..10
    ll = field[i]

    last = ll.rindex('o')
    last = 0 if last.nil?

    ll[0] = '|'

    diff = row[i]-last
    ll[last+1..row[i]] = "+"*diff if diff >0

    if map.gaps[i]!=0
      ll[map.gaps[i]] = ' '
    else
      ll[1..last] =  "o" * last
    end

    p "#{ll}| last #{last} curr #{row[i]}"
    ll.gsub!('+','o')
  end

end
