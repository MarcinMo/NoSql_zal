import time
from pymongo import MongoClient

client = MongoClient('localhost', 27017)
db = client['nosql']
collection = db.reddit2

def measureTime(a):
    start = time.clock()
    a()
    elapsed = time.clock()
    elapsed = elapsed - start
    print "Time spent in executing function %s is: %s" % (a.__name__, elapsed)

def agr1():
    x = collection.aggregate(
		[
           { $sort: { data: -1} }, { $limit: 30 }
		]
    )

def agr2():
    x = collection.aggregate(
       [
			{ $sort: { data: 1} }, { $limit: 30 }
		]
    )

for i in xrange(1,5):
    print'-' * 30
    print "Agregacja %d:" %i
    eval("measureTime(agr%d)"%i)
