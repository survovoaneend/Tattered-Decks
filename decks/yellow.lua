<<<<<<< HEAD
SMODS.Back{
	
	name = "Tattered Yellow Deck",
	key = "yellow",
    atlas = "b_side_atlas",
	pos = {x = 2, y = 0},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Yellow Deck",
		text ={
			"???"
		},
    },
	loc_vars = function(self)
        return {}
	end,
	apply = function()
	end,
	omit = true
}
=======
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
			"Money at the end of",
			"rounds is converted to a",
			"{C:attention}multiplier{} where each",
			"dollar adds {C:money}$0.1X{}.",
			"Price of everything is multiplied",
			" by the {C:attention}current ante{}.",
			"Start with {C:money}$10{}.",
			"Earn no {C:attention}Interest{}",
		},
    },
	loc_vars = function(self) 
        return {}
	end,
	apply = function()
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


>>>>>>> b27156c (idk what i'm doing)
Tattered.add_b_side("b_" .. "yellow", "b_tattered_" .. "yellow")