

def santa_run(directions):
    origin = (0, 0)
    position = origin
    houses = set()
    houses.add(origin)

    for d in directions:
        x, y = position
        if d == '^':
            y += 1
        elif d == '>':
            x += 1
        elif d == 'v':
            y -= 1
        elif d == '<':
            x -= 1
        position = x, y
        houses.add(position)

    return len(houses)


def main():
    with open('day3input.txt') as f:
        print(santa_run(f.read()))

if __name__ == '__main__':
    main()
