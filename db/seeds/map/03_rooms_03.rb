nw = Room.first

p1 = Room.find(7)

nw.update_attributes(wr: p1)

p1.update_attributes(er: nw)

se = Room.fourth

s1 = Room.find(10)

se.update_attributes(er: s1)

s1.update_attributes(wr: se)
