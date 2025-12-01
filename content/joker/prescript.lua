SMODS.Joker{
  key = "prescript",
  config = {
    extra = 'High Card',
  },
  rarity = 2,
  pos = {x = 22, y = 10},
  atlas = "jokers_atlas",
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra}}
  end,

  set_ability = function(self, card, initial, delay_sprites)
    local _poker_hands = {}
    for k,v in pairs(G.GAME.hands) do
      if SMODS.is_poker_hand_visible(k) then _poker_hands[#_poker_hands + 1] = k end
    end
    card.ability.extra = pseudorandom_element(_poker_hands, pseudoseed((card.area and card.area.config.collection) and 'prescript_fake' or 'prescript'))
  end,

  calculate = function(self, card, context)
    if G.GAME.current_round.hands_played == 0 and context.repetition and context.cardarea == G.play and next(context.poker_hands[card.ability.extra]) then
      return { repetitions = 1 }
    end
    if not context.blueprint and context.end_of_round and context.main_eval then
      local _poker_hands = {}
      for k,v in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(k) and k ~= card.ability.extra then _poker_hands[#_poker_hands + 1] = k end
      end
      card.ability.extra = pseudorandom_element(_poker_hands, pseudoseed('prescript'))
      return {
        message = localize('k_reset')
      }
    end
  end
}
