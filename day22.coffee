

MagicMissile = {
  name: 'Magic Missile'
  cost: 53
  damage: 4
}

Drain = {
  name: 'Drain'
  cost: 73
  damage: 2
  heal: 2
}

Shield = {
  name: 'Shield'
  cost: 113
  effect: {
    name: 'Shield'
    length: 6
    onStart: (player, boss) ->
      player.armor += 7
      # console.log('ARMOR UP')
    onEnd: (player, boss) ->
      player.armor -= 7
  }
}

Poison = {
  name: 'Poison'
  cost: 173
  effect: {
    name: 'Poison'
    length: 6
    onTurn: (player, boss) ->
      # console.log("Poison deals 3 damage")
      boss.hp -= 3
  }
}

Recharge = {
  name: 'Recharge'
  cost: 229
  effect: {
    name: 'Recharge'
    length: 5
    onTurn: (player, boss) ->
      # console.log("Recharge provides 101 mana")
      player.mana += 101
  }
}


spells = [MagicMissile, Drain, Shield, Poison, Recharge]


simFight = (player, boss, attacker=0, manaSpent=0, depth=0, effects=null, nextSpell=null, best=null) ->
  players = [Object.assign({}, player), Object.assign({}, boss)]
  effects = if effects? then (Object.assign({}, effect) for effect in effects) else []
  defender = (attacker + 1) % 2
  best = best ? Number.POSITIVE_INFINITY
  nameOfPlayer = if attacker == 0 then 'Player' else 'Boss'
  indent = '\t'.repeat(depth)

  if nextSpell?
    players[0].hp += nextSpell.heal ? 0
    players[1].hp -= nextSpell.damage ? 0
    players[0].mana -= nextSpell.cost
    if nextSpell.effect?
      if nextSpell.effect.onStart?
        nextSpell.effect.onStart(players[0], players[1])
      effects.push(Object.assign({}, nextSpell.effect))

  # console.log("#{indent}-- #{nameOfPlayer} turn --")
  # console.log("#{indent}- Player has #{players[0].hp} hp, #{players[0].armor} armor, #{players[0].mana} mana")
  # console.log("#{indent}- Boss has #{players[1].hp} hp")

  for effect, i in effects by -1
    if effect.onTurn?
      effect.onTurn(players[0], players[1])
    effect.length--
    if effect.length <= 0
      if effect.onEnd?
        effect.onEnd(players[0], players[1])
      # remove effect
      effects.splice(i, 1)

  # console.log('\t'.repeat(depth), ("#{effect.name} (#{effect.length})" for effect in effects))

  if attacker == 0
    # player turn - cast magic
    if players[0].hp <= 0 or players[0].mana < 53
      # player lost
      return Number.POSITIVE_INFINITY

    for spell in spells
      if spell.cost < players[0].mana and manaSpent + spell.cost < best
        # console.log("#{indent}Player casts #{spell.name}")
        cost = simFight(players[0], players[1], defender, manaSpent + spell.cost, depth + 1, effects, spell, best)
        if cost < best
          console.log('Best so far:', best)
          best = cost

  else
    # boss turn
    if players[1].hp <= 0
      return manaSpent
    players[defender].hp -= Math.max(1, players[attacker].damage - players[defender].armor)
    best = simFight(players[0], players[1], defender, manaSpent, depth + 1, effects, null, best)

  return best


module.exports.simFight = simFight

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day22input.txt')
  )

  boss = {
    armor: 0
  }

  player = {
    armor: 0
    damage: 0
    hp: 50
    mana: 500
  }

  rl.on 'line', (line) ->
    if res = line.match(/Hit Points: (\d+)/)
      boss.hp = parseInt(res[1])
    else if res = line.match(/Damage: (\d+)/)
      boss.damage = parseInt(res[1])

  rl.on 'close', ->
    console.log(simFight(player, boss))
    # console.log(simFight({armor: 0, hp: 10, mana: 250}, {hp: 13, damage: 8}))
    # console.log(simFight({armor: 0, hp: 10, mana: 250}, {hp: 14, damage: 8}))

if require.main == module
  main()
