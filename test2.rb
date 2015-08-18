require_relative  'game'
require_relative  'helper'


def test_fit
  templ = "u1 0 w".split(' ')
  rr=[0,2,3,2,2,1,0,1,1,1,0]
 
 
  for i in 1..10
    p "#{('0'*rr[i]).ljust(20, ' ')} :#{i}"
  end
  p "--------------"
  p fit_tmpl(9,templ, rr)

end



def fit_tmpl(i,templ, rr)
  rr_size = rr.size-1


  return false if templ[0] =='w' && i!=1

  return false if templ[-1] =='w' && i+templ.size!=rr.size+1

  templ.select!{|x| x!='w'}

  marks = templ.map { |ss|  ss[0]  }
  hh = templ.map { |ss|  ss.sub('d','').sub('u','').to_i  }
  zero_pos = marks.index('0')

  #p "info: marks=#{marks} hh=#{hh} zero_pos=#{zero_pos}"

  found_wrong = []
  curr= rr[i+zero_pos]

  return false if i+templ.select{|x| x!='w'}.size>rr.size

  for k in 0..templ.size-1
    ik= i+k

    if ik>rr.size-1
      break
    end

    begin

      found_wrong<<[ik,'+'] if marks[k]=='+' && rr[ik]-hh[k]!=curr
      found_wrong<<[ik,'-'] if marks[k]=='-' && rr[ik]-hh[k]!=curr
      found_wrong<<[ik,'d'] if marks[k]=='d' && rr[ik]+hh[k]>curr
      found_wrong<<[ik,'u'] if marks[k]=='u' && rr[ik]-hh[k]<curr
      found_wrong<<[ik,'0'] if marks[k]=='0' && rr[ik]!=curr

    rescue
      p "i=#{i} found=#{found_wrong}"
    end
  end

  #p "result: found correct subtemplate i:#{i} sub:#{rr[i..i+templ.size-1]}" if !found_wrong
  p found_wrong
  return found_wrong.empty?

end

def test_piece
  map = Map.new
  map.rr="0 5 5 5 6 5 4 4 4 5 5".split(' ').map{|x| x.to_i}

  arr = "III" #my test
  ss=arr.size

  for i in 0..ss-1

    p "-----round #{i+1}"
    curr_pt = arr[i]
    next_pt = arr[i+1]

    best_pos = BlackBox.anlz(map, curr_pt)
    prev_rr = map.rr.clone
    
    p "curr=#{curr_pt} next=#{next_pt} best_pos=#{best_pos}"

    Bot.set_piece(map, curr_pt, best_pos)

    show_field_h(map,prev_rr)
    clean_lines(map)
  end
end
#test_fit
test_piece