import re

from collections import defaultdict
from itertools import permutations

def distance_for_route(route, locations):
    distance = 0
    for i in range(0, len(route) - 1):
        distance += locations[route[i]][route[i + 1]]
    return distance

def main():

    with open('day9input.txt') as f:
        locations = defaultdict(dict)
        for line in f:
            res = re.match(r'(?P<origin>\w+) to (?P<destination>\w+) = (?P<distance>\d+)', line).groupdict()
            locations[res['origin']][res['destination']] = int(res['distance'])
            locations[res['destination']][res['origin']] = int(res['distance'])

        print(locations)
        best_route = None
        best_distance = -1
        worst_route = None
        worst_distance = -1
        for p in permutations(locations.keys()):
            if best_route is None:
                best_route = worst_route = p
                best_distance = worst_distance = distance_for_route(p, locations)
                worst_route = p
                
            else:
                cur_distance = distance_for_route(p, locations)
                if cur_distance < best_distance:
                    best_route = p
                    best_distance = cur_distance
                if cur_distance > worst_distance:
                    worst_route = p
                    worst_distance = cur_distance

        print(best_route, best_distance)
        print(worst_route, worst_distance)

        # print(len(locations))



if __name__ == '__main__':
    main()
