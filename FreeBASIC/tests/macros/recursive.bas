option explicit 

#define foo1(p) #p
#define foo2(p) p##p
#define foo3(p) foo1(foo2 p)
#define foo4(p) foo1(foo2(p))

	assert( foo1(foo2(bar)) = foo3((bar)) )
	assert( foo1(foo2(bar)) = foo4(bar) )