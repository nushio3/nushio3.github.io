#!/usr/bin/env python

# run this script at path:
# /usr/share/texmf/tex4ht/ht-fonts/unicode/cjk/utf8

def convert(n):
    try:
        fni = 'utf8song{:02x}.htf'.format(n)
        fno = 'udmj{:02x}.htf'.format(n)
        with(open(fni,'r')) as fpi:
            con = fpi.read().split('\n')
            con[0]  = 'udmj{:02x} 0 255'.format(n)
            con[-3] = 'udmj{:02x} 0 255'.format(n)
            with(open(fno,'w')) as fpo:
                fpo.write('\n'.join(con))
    except:
        pass
map(convert,range(1,256))
