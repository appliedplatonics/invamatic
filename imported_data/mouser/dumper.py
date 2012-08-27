#!/usr/bin/env python

from BeautifulSoup import BeautifulSoup
import re

import sys

RE_JUSTNUM=re.compile('^[\d\.]+$')

def str_scrubbed(j):
    x = str(j).replace("\t", " ").replace("'", " ")
    if RE_JUSTNUM.match(x): return x
    return '"' + x + '"'

def un_td(t):
    if t.span:
        t = t.span
    return "||".join(map(str, t.contents))

def pull_tds(cs, name):
    return map(un_td, cs('td', name))

#header = "\t".join(["part_no", "qty", "mouser_no", "manu_no", "extprice", "price", "description"])

header = "\t".join(["part_id","quantity","supplier_partno","manu_partno","cost","price","supplier_desc"])

print header

for filename in sys.argv[1:]:
    print >> sys.stderr,  "RUNNING " + filename
    f = file(filename)
    cs = BeautifulSoup(f)

    mypartnos = pull_tds(cs, 'td-partnumber')
    qtys = pull_tds(cs, 'td-qty')
    prices = pull_tds(cs, 'td-price')
    extprices = pull_tds(cs, 'td-ext-price')

    item_tables = map(lambda x: x.findParent('table'), cs('td', text=re.compile("Mouser #")))

    mouser_partnos = map(lambda x: x('td')[1]('a')[0].next, item_tables)
    manu_partnos = map(lambda x: x('td')[3]('a')[0].next, item_tables)
    descriptions = map(lambda x: x('td')[5]('a')[0].next, item_tables)

    f.close()

    cols = [mypartnos, qtys, mouser_partnos, manu_partnos, extprices,  prices, descriptions]

    for i in range(len(mypartnos)):
        data = map(lambda a: str_scrubbed(a[i]), cols)
        print "\t".join(data)
                   
