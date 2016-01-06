
runProg = (prog, registers=null) ->
  registers = registers ? { a: 0, b: 0 }

  prog = prog.split('\n')
  idx = 0

  while idx < prog.length
    line = prog[idx].match(/(\w{3}) (\w, [+-]\d+|[+-]\d+|\w)/)

    # console.log(line, registers)
    if line
      [instruction, param] = [line[1], line[2]]

      switch instruction
        when "hlf"
          registers[param] //= 2
          idx++
        when "tpl"
          registers[param] *= 3
          idx++
        when "inc"
          registers[param]++
          idx++
        when "jmp"
          idx += parseInt(param)
        when "jie", "jio"
          param = param.match(/(\w), ([+-]\d+)/)
          [r, offset] = [param[1], param[2]]
          switch instruction
            when "jie"
              if registers[r] % 2 == 0
                idx += parseInt(offset)
              else
                idx++
            when "jio"
              if registers[r] == 1
                idx += parseInt(offset)
              else
                idx++
        else
          # console.log('unknown instruction')
          idx++
    else
      # console.log('unknown instruction')
      idx++

  return registers

module.exports.runProg = runProg

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day23input.txt')
  )
  prog = ''

  rl.on 'line', (line) ->
    prog += line + '\n'

  rl.on 'close', ->
    console.log(runProg(prog))
    console.log(runProg(prog, {a: 1, b: 0}))

if require.main == module
  main()
