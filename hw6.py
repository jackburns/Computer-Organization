Jack Burns Hw6

--Part 1--

def sum3(nums):
    return sum(nums)

def rotate_left3(nums):
	return [nums[1], nums[2], nums[0]]

def max_end3(nums):
	n = max(nums[0], nums[2])
	return [n, n, n]

def make_ends(nums):
	return [nums[0], nums[len(nums) - 1]]

def has23(nums):
	return 2 in nums or 3 in nums


def count_evens(nums):
	count = 0
	for x in nums:
		if x % 2 == 0 or x % 2 == 2:
			count = count + 1
	return count

def sum13(nums):
    sum = 0
    for i in range(len(nums)):
        if nums[i] != 13:
            if i == 0 or nums[i-1] != 13:
                 sum = sum + nums[i]
    return sum

def big_diff(nums):
    return max(nums) - min(nums)

def sum67(nums):
    sum = 0
    acc = 1
    for x in nums:
        if x == 6:
            acc=0
        sum = sum + x * acc
        if acc == 0 and x == 7:
            acc=1
    return sum


def centered_average(nums):
    return (sum(nums) - min(nums) - max(nums)) / (len(nums) - 2)

def has22(nums):
    for i in range(len(nums) - 1):
        if nums[i] == 2 and nums[i + 1] == 2:
            return True
    return False

def extra_end(str):
    return 3 * str[-2:]

def without_end(str):
    return str[1:-1]
  
def double_char(str):
    return ''.join([ c+c for c in str ])

def count_code(str):
    count = 0
    for i in range(len(str)-3):
        if str[i] == 'c' and str[i+1] == 'o' and str[i+3] == 'e':
            count = count +1
    return count

def count_hi(str):
    return str.count('hi')

def end_other(a, b):
    al = a.lower()
    bl = b.lower()
    return al.endswith(bl) or bl.endswith(al)


def cat_dog(str):
    return str.count('dog') == str.count('cat')

def xyz_there(str):
    return bool(str.count('xyz') - str.count('.xyz'))

--Part 2--

def wordCount(str):
    return [len(str.split('\n')), len(str.split(' ')) , len(str)]

def mycount(str):
    mycount = [ str.count(c) for c in "0123456789 \t\n" ]
    return mycount
  
             
