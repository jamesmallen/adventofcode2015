from hashlib import md5


def find_hash(secret_key, target='00000'):
    m = md5(secret_key.encode('utf-8'))

    n = 1

    while True:
        cur_hash = m.copy()
        if n % 10000 == 0:
            print(n)
        cur_hash.update(bytes(str(n).encode('utf-8')))
        if cur_hash.hexdigest().startswith(target):
            return n

        n += 1


def main():
    with open('day4input.txt') as f:
        secret_key = f.read().strip()
        print(find_hash(secret_key))
        print(find_hash(secret_key, '000000'))


if __name__ == '__main__':
    main()
