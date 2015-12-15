import re

def main():
    global wires

    with open('day8input.txt') as f:
        counter1 = 0
        counter2 = 0
        for line in f:
            # The only escape sequences used are \\ (which represents a single backslash), \" (which represents a lone double-quote character), and \x plus two hexadecimal characters (which represents a single character with that ASCII code)

            line_copy = line

            orig = len(line)
            # make sure to include open/closing quotes
            line = re.sub(r'^"', '', line)
            line = re.sub(r'"$', '', line)
            line = re.sub(r'\\\\', r'\\', line)
            line = re.sub(r'\\"', '"', line)
            line = re.sub(r'\\x[0-9a-fA-F]{2}', '#', line)

            rep = len(line)

            line = line_copy
            line = line.replace('\\', '\\\\')
            line = line.replace('"', '\\"')
            line = '"' + line + '"'

            extra = len(line)

            counter1 += (orig - rep)
            counter2 += (extra - orig)

        print(counter1, counter2)


if __name__ == '__main__':
    main()
