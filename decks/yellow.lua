
SMODS.Back{
	
	name = "Tattered Yellow Deck",
	key = "yellow",
    atlas = "b_side_atlas",
	pos = {x = 2, y = 0},
	config = {
		b_side = true, 
		ttr_yellow = true, 
		money_mult = 0.1, 
		money_mult_min = 1.0, 
		no_interest = true,
		dollars = 6,
		base_reroll_cost = nil
	},
	loc_txt = {
		name = "Tattered Yellow Deck",
		text ={
			"Money at the end of rounds",
			"is converted to a {C:attention}multiplier{}",
			"where each dollar adds {X:money,C:white}$0.1X{}.",
			"Price of everything is multiplied",
			" by the {C:attention}current ante{}.",
			"Start with {C:money}$10{}.",
			"Earn no {C:attention}Interest{}.",
		},
    },
	loc_vars = function(self) 
        return {}
	end,
	apply = function()
		SMODS.Joker:take_ownership("delayed_grat", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'j_delayed_grat_yellow'}
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then
					card.ability.extra = 1
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("cloud_9", {
			rarity = 3,
			loc_vars = function(self, card)
				self.nine_tally = 0
            	for k, v in pairs(G.playing_cards) do
                	if v:get_id() == 9 then self.nine_tally = self.nine_tally+1 end
            	end
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'j_cloud_9_yellow', vars = {nil, ((self.nine_tally*0.1) or 0)}}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("golden", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'j_golden_yellow'}
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then
					card.ability.extra = 3
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("rocket", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'j_rocket_yellow', vars = {self.mult_value*0.1}}
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then
					card.ability.extra.increase = 1
					self.mult_value = card.ability.extra.dollars or 0
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.last_blind.boss and context.end_of_round then
					self.mult_value = card.ability.extra.dollars
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("satellite", {
			rarity = 3,
			loc_vars = function(self, card)
				self.planets_used = 0
            	for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then self.planets_used = self.planets_used + 1 end end
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'j_satellite_yellow', vars = {nil, self.planets_used*0.1 or 0}}
				end
			end,
			
			unlocked = true,
			discovered = true,
		})
		SMODS.Consumable:take_ownership("wraith",{
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'c_wraith_yellow'}
				end
			end,
			use = function(self, card, area, copier)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					play_sound('timpani')
					local card_j = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'wra')
					card_j:add_to_deck()
					G.jokers:emplace(card_j)
					card:juice_up(0.3, 0.5)
					if G.GAME.dollars ~= 0 then
						ease_dollars(-G.GAME.dollars+1, true)
					end
					return true end }))
				delay(0.6)
			end
		})
		SMODS.Blind:take_ownership("ox",{
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'bl_ox_yellow', vars = {localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}}
				end
			end,
			collection_loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_yellow then 
					return {key = 'bl_ox_yellow', vars = {localize('ph_most_played')}}
				end
			end,
			debuff_hand = function(self, cards, hand, handname, check)
				self.triggered = false
				if handname == G.GAME.current_round.most_played_poker_hand and not G.GAME.blind.disabled then
					self.triggered = true
					if not check then
						ease_dollars(-G.GAME.dollars+1, true)
					end
				end
			end
		})
	end,

	calculate = function(self, card, context)
		if context.end_of_round and G.GAME.last_blind.boss then
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
						G.GAME.discount_percent = (-(G.GAME.round_resets.ante)*100)
                        for k, v in pairs(G.I.CARD) do
                           if v.set_cost then v:set_cost() end
                        end
					if not G.GAME.selected_back.effect.config.base_reroll_cost then
						G.GAME.selected_back.effect.config.base_reroll_cost = G.GAME.round_resets.reroll_cost
					end
					G.GAME.reroll_scaling = G.GAME.round_resets.ante+1
					G.GAME.round_resets.reroll_cost = G.GAME.selected_back.effect.config.base_reroll_cost * (G.GAME.round_resets.ante+1)
					calculate_reroll_cost(true)
					return true
				end
			}))
		end
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "yellow", "b_tattered_" .. "yellow")