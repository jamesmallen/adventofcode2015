from day2 import surface_area, ribbon_length


def test_surface_area():
    for l, w, h, total in [
        (2, 3, 4, 58),
        (1, 1, 10, 43),
    ]:
        yield surface_area_checker, l, w, h, total


def test_ribbon_length():
    for l, w, h, total in [
        (2, 3, 4, 34),
        (1, 1, 10, 14),
    ]:
        yield ribbon_length_checker, l, w, h, total


def surface_area_checker(l, w, h, total):
    assert surface_area(l, w, h) == total


def ribbon_length_checker(l, w, h, total):
    assert ribbon_length(l, w, h) == total
