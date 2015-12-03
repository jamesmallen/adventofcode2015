from day3 import santa_run


def test_santa_run():
    for directions, houses in [
        ('>', 2),
        ('^>v<', 4),
        ('^v^v^v^v^v', 2),
    ]:
        yield santa_run_checker, directions, houses


def santa_run_checker(directions, houses):
    assert santa_run(directions) == houses
