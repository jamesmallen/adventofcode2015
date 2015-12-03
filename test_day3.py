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


def test_robo_run():
    for directions, houses in [
        ('^v', 3),
        ('^>v<', 3),
        ('^v^v^v^v^v', 11),
    ]:
        yield robo_run_checker, directions, houses


def robo_run_checker(directions, houses):
    assert santa_run(directions, santas=2) == houses
