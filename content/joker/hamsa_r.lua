SMODS.Joker {
  key = "hamsa_r",
  config = {
    extra = {
      luck = 3,
    },
  },
  rarity = 1,
  pos = { x = 22, y = 6 },
  atlas = "jokers_atlas",
  cost = 5,
  unlocked = false,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    local vars = { vars = { card.ability.extra.luck } }
    if card.area and card.area.config.collection then
      vars.key = 'j_paperback_hamsa_r_collection'
    end
    return vars
  end,

  locked_loc_vars = function(self, info_queue, card)
    local name = "???"
    if G.P_CENTERS['j_paperback_hamsa'].unlocked then
      name = localize { type = 'name_text', set = 'Joker', key = 'j_paperback_hamsa' }
    end
    return { vars = { name, 1 } }
  end,

  -- can only be obtained from having the initial hamsa
  in_pool = function(self, args) return false end,

  calculate = function(self, card, context)
    if G.GAME.current_round.hands_left == 0 and context.mod_probability then
      return { numerator = context.numerator + card.ability.extra.luck }
    end
    if not context.blueprint and context.end_of_round and context.main_eval then
      PB_UTIL.use_consumable_animation(nil, card, function()
        card:set_ability(G.P_CENTERS['j_paperback_hamsa'])
      end)
      return {
        message = localize('paperback_hamsa_reverse'),
        colour = G.C.FILTER
      }
    end
  end
}
