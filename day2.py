

def surface_area(l, w, h):
    return 2*l*w + 2*w*h + 2*h*l + min(l*w, w*h, h*l)


def volume(l, w, h):
    return l*w*h


def ribbon_length(l, w, h):
    return min(2*l + 2*w, 2*w + 2*h, 2*h + 2*l) + volume(l, w, h)


def main():
    with open('day2input.txt') as f:
        total_surface_area = 0
        total_ribbon_length = 0

        for line in f:
            line = line.strip()
            l, w, h = map(int, line.split('x'))
            total_surface_area += surface_area(l, w, h)
            total_ribbon_length += ribbon_length(l, w, h)

        print(total_surface_area)
        print(total_ribbon_length)

if __name__ == '__main__':
    main()
