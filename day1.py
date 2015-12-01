part = 'b'

with open('day1input.txt') as f:
    instructions = f.read()
    my_floor = 0
    position = 0
    for c in instructions:
        position += 1
        if c == '(':
            my_floor += 1
        elif c == ')':
            my_floor -= 1

        if part == 'b' and my_floor < 0:
            print('Entered basement at {}'.format(position))
            break
    print(my_floor)
