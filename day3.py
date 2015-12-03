

def santa_run(directions, santas=1):
    origin = (0, 0)
    positions = [origin] * santas
    current_mover = 0
    houses = set()
    houses.add(origin)

    for d in directions:
        x, y = positions[current_mover]
        if d == '^':
            y += 1
        elif d == '>':
            x += 1
        elif d == 'v':
            y -= 1
        elif d == '<':
            x -= 1
        positions[current_mover] = x, y
        houses.add(positions[current_mover])
        current_mover += 1
        current_mover %= santas

    return len(houses)


def main():
    with open('day3input.txt') as f:
        directions = f.read()
        print(santa_run(directions))
        print(santa_run(directions, santas=2))

if __name__ == '__main__':
    main()
