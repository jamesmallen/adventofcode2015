
# Weapons:    Cost  Damage  Armor
weapons = '''
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0
'''

# Armor:      Cost  Damage  Armor
armor = '''
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5
None          0     0       0
'''

# Rings:      Cost  Damage  Armor
rings = '''
Damage +1    25     1       0
Damage +2    50     2       0
Damage +3   100     3       0
Defense +1   20     0       1
Defense +2   40     0       2
Defense +3   80     0       3
None          0     0       0
None          0     0       0
'''

shopRE = /(.*?)\s{2,}(\d*)\s{2,}(\d*)\s{2,}(\d*)/

shop = {
  weapons: ({name:res[1], cost:parseInt(res[2]), damage:parseInt(res[3]), armor:parseInt(res[4])} for res in (line.match(shopRE) for line in weapons.split('\n') when line.trim()?))
  armor: ({name:res[1], cost:parseInt(res[2]), damage:parseInt(res[3]), armor:parseInt(res[4])} for res in (line.match(shopRE) for line in armor.split('\n') when line.trim()?))
  rings: ({name:res[1], cost:parseInt(res[2]), damage:parseInt(res[3]), armor:parseInt(res[4])} for res in (line.match(shopRE) for line in rings.split('\n') when line.trim()?))
}


#You must buy exactly one weapon; no dual-wielding.
# Armor is optional, but you can't use more than one.
# You can buy 0-2 rings (at most one for each hand).
# You must use any items you buy.
# The shop only has one of each item, so you can't buy, for example, two rings of Damage +3.


simFight = (player, boss) ->
  players = [Object.assign({}, player), Object.assign({}, boss)]
  attacker = 0
  while players.every((a) -> a.hp > 0)
    defender = (attacker + 1) % 2
    players[defender].hp -= Math.max(1, players[attacker].damage - players[defender].armor)
    attacker = defender
    # console.log(players)

  return {player: players[0].hp, boss: players[1].hp}


findCheapestOutfit = (boss, playerHp = 100) ->
  bestPrice = null
  for weapon in shop.weapons
    for armor in shop.armor
      for ring1, ring1Index in shop.rings
        otherRings = shop.rings[..]
        otherRings.splice(ring1Index, 1)
        for ring2 in otherRings
          cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
          if bestPrice? and cost >= bestPrice
            continue

          player = {
            hp: playerHp
            damage: weapon.damage + armor.damage + ring1.damage + ring2.damage
            armor: weapon.armor + armor.armor + ring1.armor + ring2.armor
          }

          res = simFight(player, boss)
          if res.player > 0
            bestPrice = cost
            # console.log(weapon, armor, ring1, ring2)
  return bestPrice


findExpensivestOutfit = (boss, playerHp = 100) ->
  worstPrice = null
  for weapon in shop.weapons
    for armor in shop.armor
      for ring1, ring1Index in shop.rings
        otherRings = shop.rings[..]
        otherRings.splice(ring1Index, 1)
        for ring2 in otherRings
          cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
          if worstPrice? and cost <= worstPrice
            continue

          player = {
            hp: playerHp
            damage: weapon.damage + armor.damage + ring1.damage + ring2.damage
            armor: weapon.armor + armor.armor + ring1.armor + ring2.armor
          }

          res = simFight(player, boss)
          if res.player <= 0
            worstPrice = cost
            # console.log(weapon, armor, ring1, ring2)
  return worstPrice


module.exports.simFight = simFight

main = () ->
  rl = require('readline').createInterface(
    input: require('fs').createReadStream('day21input.txt')
  )

  boss = {}

  rl.on 'line', (line) ->
    if res = line.match(/Hit Points: (\d+)/)
      boss.hp = parseInt(res[1])
    else if res = line.match(/Damage: (\d+)/)
      boss.damage = parseInt(res[1])
    else if res = line.match(/Armor: (\d+)/)
      boss.armor = parseInt(res[1])

  rl.on 'close', ->
    console.log(findCheapestOutfit(boss))
    console.log(findExpensivestOutfit(boss))

if require.main == module
  main()
