from day4 import find_hash


def test_find_hash():
    for secret_key, number in [
        ('abcdef', 609043),
        ('pqrstuv', 1048970),
    ]:
        yield find_hash_checker, secret_key, number


def find_hash_checker(secret_key, number):
    assert find_hash(secret_key) == number
