SMODS.Joker {
  key = "book_of_life",
  config = {
    extra = {
      max = 4,
      current = 0,
      antes = -2,
    },
  },
  rarity = 3,
  pos = { x = 14, y = 7 },
  atlas = "jokers_atlas",
  cost = 8,
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.max, card.ability.extra.max - card.ability.extra.current, card.ability.extra.antes } }
  end,

  calculate = function(self, card, context)
    if not context.blueprint and context.end_of_round and context.main_eval and not context.game_over then
      card.ability.extra.current = card.ability.extra.current + 1
      if card.ability.extra.current >= card.ability.extra.max then
        PB_UTIL.destroy_joker(card)
        ease_ante(card.ability.extra.antes)
        G.GAME.round_resets.blind_ante = (G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante) + card.ability.extra.antes
        return {
          message = localize('paperback_destroyed_ex'),
          colour = G.C.MULT
        }
      else
        return {
          message = localize {
            type = 'variable',
            key = 'paperback_a_completion',
            vars = {
              card.ability.extra.current,
              card.ability.extra.max,
            },
          }
        }
      end
    end
  end
}
