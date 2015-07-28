require_relative  'helper'

class BotL

def self.anlz(rr)
    p "bol L, anlz, #{rr}"
    max = rr.max
    min = rr.min
    diff_not_big = max-min<3

    res = []

    #   #
    # ###
    for i in 1..8
      res<< [i,0, rr[i]] if  rr[i] == rr[i+1] && rr[i+1] == rr[i+2] && (rr[i]!=max || diff_not_big)
    end

    #  ##
    #   #
    #   #
    for i in 1..9
      res<< [i, 1, rr[i+1]] if  rr[i]-2 == rr[i+1] && (rr[i]!=max || diff_not_big)
    end

    # ###
    # #
    for i in 1..8
      res<< [i,2, rr[i]] if  rr[i]+1 == rr[i+1] && rr[i+1] == rr[i+2]  && (rr[i]!=max || diff_not_big)
    end

    #  #
    #  #
    #  ##
    for i in 1..9
      res<< [i, 3, rr[i]] if  rr[i] == rr[i+1] && (rr[i+1]!=max || diff_not_big)
    end



    find_min_level(res)
  end

end