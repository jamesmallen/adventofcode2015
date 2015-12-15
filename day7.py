import re

sample_input = '''123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i'''

sample_output = '''d: 72
e: 507
f: 492
g: 114
h: 65412
i: 65079
x: 123
y: 456'''

sample_output = sample_output.splitlines()
test_output = {}
for line in sample_output:
    match = re.match(r'(\w+): (\d+)', line.strip())
    test_output[match.group(1)] = int(match.group(2))

wires = {}


class Wire:

    def __init__(self):
        self._value = None
        pass

    @property
    def value(self):
        if self._value is None:
            self._value = self.evaluate()
        return self._value

    def check(self, keys):
        global wires
        for key in keys:
            if type(self.__dict__[key]) is str:
                # remap str wire to wire object
                self.__dict__[key] = wires[self.__dict__[key]]


class Gate(Wire):
    pass


class PassGate(Gate):

    def __init__(self, x):
        super().__init__()
        self.x = x

    def evaluate(self):
        self.check(['x'])
        return self.x.value


class ValueGate(Gate):

    def __init__(self, x):
        super().__init__()
        self.x = x

    def evaluate(self):
        return self.x


class UnaryGate(Gate):

    def __init__(self, x):
        super().__init__()
        if type(x) is int:
            self.x = ValueGate(x)
        else:
            self.x = x

    def evaluate(self):
        self.check(['x'])
        return self._evaluate()


class NotGate(UnaryGate):

    def _evaluate(self):
        # return ~ self.x.value
        return 65535 - self.x.value


class BinaryGate(Gate):

    def __init__(self, x, y):
        super().__init__()
        if type(x) is int:
            self.x = ValueGate(x)
        else:
            self.x = x
        if type(y) is int:
            self.y = ValueGate(y)
        else:
            self.y = y

    def evaluate(self):
        self.check(['x', 'y'])
        return self._evaluate()


class AndGate(BinaryGate):

    def _evaluate(self):
        return self.x.value & self.y.value


class OrGate(BinaryGate):

    def _evaluate(self):
        return self.x.value | self.y.value


class LShiftGate(BinaryGate):

    def _evaluate(self):
        return self.x.value << self.y.value


class RShiftGate(BinaryGate):

    def _evaluate(self):
        return self.x.value >> self.y.value


def main():
    global wires

    with open('day7input.txt') as f:
        for line in f:
            # for line in sample_input.splitlines():
            line = line.strip()
            for gate_type, regex in [
                (AndGate, re.compile(r'(?P<x>\w+)\s*AND\s*(?P<y>\w+)\s*->\s*(?P<dst>\w+)')),
                (OrGate, re.compile(r'(?P<x>\w+)\s*OR\s*(?P<y>\w+)\s*->\s*(?P<dst>\w+)')),
                (LShiftGate, re.compile(r'(?P<x>\w+)\s*LSHIFT\s*(?P<y>\w+)\s*->\s*(?P<dst>\w+)')),
                (RShiftGate, re.compile(r'(?P<x>\w+)\s*RSHIFT\s*(?P<y>\w+)\s*->\s*(?P<dst>\w+)')),
                (NotGate, re.compile(r'NOT\s*(?P<x>\w+)\s*->\s*(?P<dst>\w+)')),
                (ValueGate, re.compile(r'(?P<x>\d+)\s*->\s*(?P<dst>\w+)')),
                (PassGate, re.compile(r'(?P<x>\w+)\s*->\s*(?P<dst>\w+)')),
            ]:
                res = regex.match(line)
                if res:
                    res = res.groupdict()
                    dst = res.pop('dst')
                    for key, value in res.items():
                        if re.match(r'^\d+$', value):
                            res[key] = int(value)
                        # else:
                        #     res[key] = wires[value]
                    wires[dst] = gate_type(**res)
                    break

    # print(wires)
    # for key, value in test_output.items():
    #     print(key, wires[key].value, value)
    #     assert wires[key].value == value
    # for key, value in wires.items():
    #     print(key, value.value)
    print(wires['a'].value)

if __name__ == '__main__':
    main()
