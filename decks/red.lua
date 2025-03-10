<<<<<<< HEAD
---@diagnostic disable: trailing-space, redundant-parameter
SMODS.Back{
	name = "Tattered Red Deck",
	key = "red",
    atlas = "b_side_atlas",
	pos = {x = 0, y = 0},
	config = {
		b_side = true, 
		hands = 24-4, 
		discards = 32-3, 
		ttr_red = true, 
		cards_bought = 0, 
		boss_hands = 0, 
		boss_discards = 0, 
		normal_hands = 0, 
		normal_discards = 0
	},
	loc_txt = {
		name = "Tattered Red Deck",
		text ={
			"Start run with",
			"{C:blue}#1#{} hands and {C:red}#2#{} discards",
			"that last {C:attention}the entire run{}",
			"{C:blue}Hand{} money is divided by {C:attention}6{}",
			"Various actions give hands/discards",
			"{C:inactive,s:0.8}Actions shown in run info{}"
		},
    },
	loc_vars = function(self)
        return {
            vars = { self.config.hands+4, self.config.discards+3 }
        }
	end,
	
	apply = function()
		G.GAME.modifiers.money_per_hand = 1/6
		--Reworks
		SMODS.Joker:take_ownership("drunkard", {
			discovered = true,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then
					if context.end_of_round and not (context.individual or context.repetition) and not context.blueprint then
						if G.GAME.blind.boss then
							G.E_MANAGER:add_event(Event({
								trigger = "immediate",
								func = function()
									G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + 1
									boss_discards = G.GAME.eor_boss_discards_perm + G.GAME.eor_boss_discards_temp
									return true
								end
							}))
						end
					end
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.d_size = 0
				else
					card.ability.d_size = 1
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_drunkard_red'}
				end
			end
		})
		SMODS.Joker:take_ownership("troubadour", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra.h_size = 2
					card.ability.extra.h_plays = 0
				else
					card.ability.extra.h_size = 2
					card.ability.extra.h_plays = -1
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then 
					if context.before or context.setting_blind and not context.blueprint then
						if pseudorandom('troubadour') < G.GAME.probabilities.normal/4 and G.GAME.current_round.hands_left > 2 then
							G.GAME.hands_per_hand = 2
						else
							G.GAME.hands_per_hand = 1
						end
					end
					if context.selling_self then
						G.GAME.hands_per_hand = 1
					end
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_troubadour_red', vars = {''..(G.GAME and G.GAME.probabilities.normal or 1)}}
				end
			end,
			
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("merry_andy", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.d_size = 0
				else
					card.ability.d_size = 3
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then
					if context.end_of_round and G.GAME.current_round.discards_used <= 2 and not (context.individual or context.repetition) and not context.blueprint then
						if G.GAME.blind.boss then
							G.E_MANAGER:add_event(Event({
								trigger = "immediate",
								func = function()
									G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + G.GAME.current_round.discards_used
									return true
								end
							}))
						else
							G.E_MANAGER:add_event(Event({
								trigger = "immediate",
								func = function()
									G.GAME.eor_normal_discards_temp = G.GAME.eor_normal_discards_temp + G.GAME.current_round.discards_used
									return true
								end
							}))
						end
						
					end
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_merry_andy_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("banner", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 5
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("delayed_grat", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 8
				else
					card.ability.extra = 2
				end
			end,
			calc_dollar_bonus = function(self, card)
				if G.GAME.current_round.discards_used == 0 then
					return card.ability.extra
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_delayed_grat_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("dusk", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					local status_text
					if G.GAME.current_round.hands_played >= 3 then
						status_text = 'Active!'
					else
						status_text = G.GAME.current_round.hands_played.. '/3 hands played'
					end
					return {key = 'j_dusk_red', vars = {1, status_text}}
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.current_round.hands_played >= 2 then
					if context.cardarea == G.play and context.repetition and G.GAME.current_round.hands_played >= 3 then
						return {
							message = localize("k_again_ex"),
							repetitions = 1,
							card = card,
						}
					end
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("acrobat", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					local status_text
					if G.GAME.current_round.hands_played >= 3 then
						status_text = 'Active!'
					else
						status_text = G.GAME.current_round.hands_played.. '/3 hands played'
					end
					return {key = 'j_acrobat_red', vars = {3, status_text, G.GAME.current_round.hands_played}}
				end
			end,
			calculate = function(self, card, context)
				if context.joker_main and G.GAME.current_round.hands_played >= 2 then
					if G.GAME.current_round.hands_played >= 3 then
						return {
							message = localize{type='variable',key='a_xmult',vars = {3}},
                        	Xmult_mod = 3,
						}
					end
				end
			end,	
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("mystic_summit", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra.mult = nil
					card.ability.extra.Xmult = 4
					card.ability.extra.d_remaining = 0
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then
					if context.joker_main and G.GAME.current_round.discards_left == card.ability.extra.d_remaining then
						return{
							message = localize{type='variable',key='a_xmult',vars={4}},
                        	Xmult_mod = 4
						}
					end
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_mystic_summit_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("j_burglar", {
			calculate = function(self, card, context)
				if context.setting_blind and not context.blueprint then
					return {
						G.E_MANAGER:add_event(Event({func = function()
							if G.GAME.current_round.discards_left > 0 then
								ease_hands_played(math.floor((G.GAME.current_round.discards_left)/2))
								ease_discard(-G.GAME.current_round.discards_left, nil, true)
							end
						return true end }))
					}
				end		
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					local hands_gained
					hands_gained = math.floor((G.GAME.current_round.discards_left)/2)
					return {key = 'j_burglar_red', vars = {hands_gained}}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("yorick", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_yorick_red'}
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra.xmult = 1
					card.ability.extra.discards = 15
					card.ability.yorick_discards = 15
				end
			end,
			unlocked = true,
			discovered = true,
		})
		
		SMODS.Voucher:take_ownership("grabber", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_boss_hands_perm = G.GAME.eor_boss_hands_perm + 1
			end,	
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_grabber_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Voucher:take_ownership("nacho_tong", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_normal_hands_perm = G.GAME.eor_normal_hands_perm + 1
			end,	
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_nacho_tong_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Voucher:take_ownership("wasteful", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_boss_discards_perm = G.GAME.eor_boss_discards_perm + 1
			end,	
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_wasteful_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Voucher:take_ownership("recyclomancy", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_normal_discards_perm = G.GAME.eor_normal_discards_perm + 1
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_recyclomancy_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		
		SMODS.Blind:take_ownership("water", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_water_red'}
				end
			end,
			collection_loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_water_red'}
				end
			end,
			set_blind = function(self,card)
				G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + G.GAME.current_round.discards_left - 2
			end,
			disable = function(self)
				ease_hands_played(self.discards_sub)
				G.GAME.eor_boss_discards_temp = 0
			end,
			discovered = true,
			defeated = true
		})
		SMODS.Blind:take_ownership("needle", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_needle_red'}
				end
			end,
			collection_loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_needle_red'}
				end
			end,
			set_blind = function(self,card)
				if not G.GAME.blind.disabled then 
					G.GAME.eor_boss_hands_temp = G.GAME.eor_boss_hands_temp + G.GAME.current_round.hands_left - 3
				end
			end,
			disable = function(self,card)
				ease_hands_played(self.hands_sub)
				G.GAME.eor_boss_hands_temp = 0
			end,
			
			discovered = true,
			defeated = true
		})
	end,
	calculate = function(self, card, context)
		boss_hands = G.GAME.eor_boss_hands_perm +G.GAME.eor_boss_hands_temp
		boss_discards = G.GAME.eor_boss_discards_perm +G.GAME.eor_boss_discards_temp
		normal_hands = G.GAME.eor_normal_hands_perm +G.GAME.eor_normal_hands_temp
		normal_discards = G.GAME.eor_normal_discards_perm +G.GAME.eor_normal_discards_temp
		local megapacks = {
			p_arcana_mega_1 = true,
			p_arcana_mega_2 = true,
			p_celestial_mega_1 = true,
			p_celestial_mega_2 = true,
			p_spectral_mega_1 = true,
			p_standard_mega_1 = true,
			p_standard_mega_2 = true,
			p_buffoon_mega_1 = true,
		}
		if context.buying_card or context.open_booster or context.reroll_shop then
			G.GAME.selected_back.effect.config.cards_bought = G.GAME.selected_back.effect.config.cards_bought + 1
		end
		if context.ending_shop then
			if G.GAME.selected_back.effect.config.cards_bought == 0 then
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(2)
					ease_discard(2)
				return true end }))
			else
				G.GAME.selected_back.effect.config.cards_bought = 0
			end
		end
		print(G.GAME.selected_back.effect.config.cards_bought)
		if context.selling_card then
			if context.card.ability.set == "Joker" then
				if context.card.config.center.rarity == 3 then
					G.E_MANAGER:add_event(Event({func = function()
						ease_hands_played(1)
					return true end }))
				else 
					G.E_MANAGER:add_event(Event({func = function()
						ease_discard(1)
					return true end }))
				end
			end
		end
		if context.skipping_booster then
			if megapacks[SMODS.OPENED_BOOSTER.config.center.key] then
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(1)
				return true end }))
			else
				G.E_MANAGER:add_event(Event({func = function()
					ease_discard(1)
				return true end }))
			end
		end
		if context.skip_blind then 
			G.E_MANAGER:add_event(Event({func = function()
				ease_hands_played(1)
			return true end }))
		end
	
		if context.end_of_round and G.GAME.last_blind.boss and not context.repetition and not context.individual then
			if G.GAME.current_round.hands_played == 1 then	
				G.GAME.eor_boss_hands_temp = G.GAME.eor_boss_hands_temp + 1
				boss_hands = G.GAME.eor_boss_hands_perm + G.GAME.eor_boss_hands_temp
			end
			if G.GAME.current_round.discards_used == 0 then
				G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + 2
				boss_discards = G.GAME.eor_boss_discards_perm + G.GAME.eor_boss_discards_temp
			end
		end
		if context.end_of_round and G.GAME.current_round.hands_left == 0 and not context.repetition and not context.individual then
			if G.GAME.last_blind.boss then	
				G.GAME.eor_boss_hands_temp = G.GAME.eor_boss_hands_temp + 2
				boss_hands = G.GAME.eor_boss_hands_perm + G.GAME.eor_boss_hands_temp
			else 
				G.GAME.eor_normal_hands_temp = G.GAME.eor_normal_hands_temp + 2
				normal_hands = G.GAME.eor_normal_hands_perm + G.GAME.eor_normal_hands_temp
			end
		end
		if context.end_of_round and (boss_discards > 0 or normal_discards > 0) and not context.repetition and not context.individual then
			if G.GAME.last_blind.boss then
				G.E_MANAGER:add_event(Event({func = function()
					ease_discard(boss_discards)
					G.GAME.eor_boss_discards_temp = 0
				return true end }))
			else
				G.E_MANAGER:add_event(Event({func = function()
					ease_discard(normal_discards)
					G.GAME.eor_normal_discards_temp = 0
				return true end }))
			end	
		end	
		if context.end_of_round and (boss_hands > 0 or normal_hands > 0) and not context.repetition and not context.individual then
			if G.GAME.last_blind.boss then
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(boss_hands)
					G.GAME.eor_boss_hands_temp = 0
				return true end }))
			else
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(normal_hands)
					G.GAME.eor_normal_hands_temp = 0
				return true end }))
			end	
		end	
	end,
	omit = true
}

function G.UIDEF.deck_gimmicks()
	local card = Card(G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h, G.CARD_W*1.2, G.CARD_H*1.2, pseudorandom_element(G.P_CARDS), G.P_CENTERS.c_base, {bypass_back = G.GAME.selected_back.effect.center.pos, playing_card = 10, viewed_back = true})
    card.sprite_facing = 'back'
    card.facing = 'back'
	local actions_data = {
    { label = "Selling a Joker:            ", hands = 0, discards = 1, subtext_discards = "(+1 hand if Rare)" },
    { label = "Skipping a Booster:            ", hands = 0, discards = 1, subtext_discards = "(+1 hand if Mega)" },
    { label = "Skipping a Blind:                ", hands = 1, discards = 0, },
    { label = "Leaving the Shop without buying anything:", hands = 2, discards = 2 },
    { label = "Beating a Boss Blind in one hand:", hands = 1, discards = 0 },
    { label = "Beating a Boss Blind without discarding:", hands = 0, discards = 2 },
	{ label = "Beating a Blind with 0 hands remaining:", hands = 2, discards = 0 },
  }

  local actions_list = {}
  for _, action in ipairs(actions_data) do
    local hands_text = action.hands > 0 and "+" .. action.hands .. " " .. localize('k_hud_hands') or nil
    local discards_text = action.discards > 0 and "+" .. action.discards .. " " .. localize('k_hud_discards') or nil
    local subtext_hands = action.subtext_hands and { n = G.UIT.T, config = { text = action.subtext_hands, scale = 0.20, colour = G.C.ORANGE, shadow = true } } or nil
      local subtext_discards = action.subtext_discards and { n = G.UIT.T, config = { text = action.subtext_discards, scale = 0.20, colour = G.C.ORANGE, shadow = true } } or nil


    actions_list[#actions_list+1] = {
      n = G.UIT.R,
      config = { align = "cm", padding = 0.2 },
      nodes = {
        {
          n = G.UIT.C,
          config = { align = 'cl', minw = 1, maxw = 4 },
          nodes = {
            { n = G.UIT.T, config = { text = action.label .. "", scale = 0.35, colour = G.C.WHITE } },
          },
        },
        {
          n = G.UIT.C,
          config = { align = 'cr', minw = 4, padding = 0.1, maxw = 5 },
          nodes = {
            hands_text and {
              n = G.UIT.C, config = {align = 'cm'},
              nodes = {
                {
                  n = G.UIT.C, config = {align = 'cm'},
                  nodes = {
                    { n = G.UIT.T, config = { text = hands_text, scale = 0.35, colour = G.C.BLUE, shadow = true } },
                    subtext_hands,
                  }
                }
              }
            } or nil,
            discards_text and {
              n = G.UIT.C, config = {align = 'cm'},
              nodes = {
                {
                  n = G.UIT.C, config = {align = 'cm'},
                  nodes = {
                    (hands_text and discards_text) and { n = G.UIT.T, config = { text = " and ", scale = 0.35, colour = G.C.WHITE, shadow = true } } or nil,
                    { n = G.UIT.T, config = { text = discards_text, scale = 0.35, colour = G.C.RED, shadow = true } },
                    subtext_discards,
                  }
                }
              }
            } or nil,
            
          },
        },
      },
    }
  end
	return
	{n = G.UIT.ROOT, config = {r = 0.1, minw = 10, minh = 8, align = "cr", padding = 0.2, colour = G.C.BLACK}, nodes = {
		{n = G.UIT.C, config = {r = 0.1, minw = 1, minh = 8, align = "cr", padding = 0.05, colour = G.C.L_BLACK}, nodes = {
			{n=G.UIT.C, config={align = "cm", minw = 1, padding = 0.05, r = 0.1, colour = G.C.L_BLACK, emboss = 0.0}, nodes={
				{n=G.UIT.R, config={align = "tm", minw = 2.5, padding = 0.05, r = 0.1, colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), emboss = 0.05}, nodes={
					{n=G.UIT.R, config={align = "tm", minw = 2.5, padding = 0.05, r = 0.1, colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), emboss = 0.0}, nodes={
						{n=G.UIT.O, config={object = DynaText({string = G.GAME.selected_back.loc_name, colours = {G.C.WHITE}, bump = true, rotate = true, shadow = true, scale = 0.6 - string.len(G.GAME.selected_back.loc_name)*0.01})}},
					}},
					{n=G.UIT.R, config={align = "tm", minw = 2.5, padding = 0.05, r = 0.1, colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), emboss = 0.0}, nodes={
						{n=G.UIT.O, config={object = card}}
					}},	
				}},
				{n=G.UIT.R, config={align = "cm", r = 0.1, padding = 0.05, minw = 2.5, minh = 1.3, colour = G.C.WHITE, emboss = 0.05}, nodes={
					{n=G.UIT.O, config={object = UIBox{
					  definition = G.GAME.selected_back:generate_UI(nil,0.7, 0.5, G.GAME.challenge),
					  config = {offset = {x=0,y=0}}
					}}}
				}}
			}}
		}},
		{n = G.UIT.C, config = {align = 'cr', padding = 0.15}, nodes = actions_list },
	}}
end
Tattered.add_b_side("b_" .. "red", "b_tattered_" .. "red")
=======
---@diagnostic disable: trailing-space, redundant-parameter
SMODS.Back{
	name = "Tattered Red Deck",
	key = "red",
    atlas = "b_side_atlas",
	pos = {x = 0, y = 0},
	config = {
		b_side = true, 
		hands = 24-4, 
		discards = 32-3, 
		ttr_red = true, 
		cards_bought = 0, 
		boss_hands = 0, 
		boss_discards = 0, 
		normal_hands = 0, 
		normal_discards = 0
	},
	loc_txt = {
		name = "Tattered Red Deck",
		text ={
			"Start run with",
			"{C:blue}#1#{} hands and {C:red}#2#{} discards",
			"that last {C:attention}the entire run{}",
			"{C:blue}Hand{} money is divided by {C:attention}6{}",
			"Various actions give hands/discards",
			"{C:inactive,s:0.8}Actions shown in run info{}"
		},
    },
	loc_vars = function(self)
        return {
            vars = { self.config.hands+4, self.config.discards+3 }
        }
	end,
	
	apply = function()
		G.GAME.modifiers.money_per_hand = 1/6
		--Reworks
		SMODS.Joker:take_ownership("drunkard", {
			discovered = true,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then
					if context.end_of_round and not (context.individual or context.repetition) and not context.blueprint then
						if G.GAME.blind.boss then
							G.E_MANAGER:add_event(Event({
								trigger = "immediate",
								func = function()
									G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + 1
									boss_discards = G.GAME.eor_boss_discards_perm + G.GAME.eor_boss_discards_temp
									return true
								end
							}))
						end
					end
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.d_size = 0
				else
					card.ability.d_size = 1
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_drunkard_red'}
				end
			end
		})
		SMODS.Joker:take_ownership("troubadour", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra.h_size = 2
					card.ability.extra.h_plays = 0
				else
					card.ability.extra.h_size = 2
					card.ability.extra.h_plays = -1
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then 
					if context.before or context.setting_blind and not context.blueprint then
						if pseudorandom('troubadour') < G.GAME.probabilities.normal/4 and G.GAME.current_round.hands_left > 2 then
							G.GAME.hands_per_hand = 2
						else
							G.GAME.hands_per_hand = 1
						end
					end
					if context.selling_self then
						G.GAME.hands_per_hand = 1
					end
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_troubadour_red', vars = {''..(G.GAME and G.GAME.probabilities.normal or 1)}}
				end
			end,
			
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("merry_andy", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.d_size = 0
				else
					card.ability.d_size = 3
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then
					if context.end_of_round and G.GAME.current_round.discards_used <= 2 and not (context.individual or context.repetition) and not context.blueprint then
						if G.GAME.blind.boss then
							G.E_MANAGER:add_event(Event({
								trigger = "immediate",
								func = function()
									G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + G.GAME.current_round.discards_used
									return true
								end
							}))
						else
							G.E_MANAGER:add_event(Event({
								trigger = "immediate",
								func = function()
									G.GAME.eor_normal_discards_temp = G.GAME.eor_normal_discards_temp + G.GAME.current_round.discards_used
									return true
								end
							}))
						end
						
					end
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_merry_andy_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("banner", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 5
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("delayed_grat", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 8
				else
					card.ability.extra = 2
				end
			end,
			calc_dollar_bonus = function(self, card)
				if G.GAME.current_round.discards_used == 0 then
					return card.ability.extra
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_delayed_grat_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("dusk", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					local status_text
					if G.GAME.current_round.hands_played >= 3 then
						status_text = 'Active!'
					else
						status_text = G.GAME.current_round.hands_played.. '/3 hands played'
					end
					return {key = 'j_dusk_red', vars = {1, status_text}}
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.current_round.hands_played >= 2 then
					if context.cardarea == G.play and context.repetition and G.GAME.current_round.hands_played >= 3 then
						return {
							message = localize("k_again_ex"),
							repetitions = 1,
							card = card,
						}
					end
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("acrobat", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					local status_text
					if G.GAME.current_round.hands_played >= 3 then
						status_text = 'Active!'
					else
						status_text = G.GAME.current_round.hands_played.. '/3 hands played'
					end
					return {key = 'j_acrobat_red', vars = {3, status_text, G.GAME.current_round.hands_played}}
				end
			end,
			calculate = function(self, card, context)
				if context.joker_main and G.GAME.current_round.hands_played >= 2 then
					if G.GAME.current_round.hands_played >= 3 then
						return {
							message = localize{type='variable',key='a_xmult',vars = {3}},
                        	Xmult_mod = 3,
						}
					end
				end
			end,	
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("mystic_summit", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra.mult = nil
					card.ability.extra.Xmult = 4
					card.ability.extra.d_remaining = 0
				end
			end,
			calculate = function(self, card, context)
				if G.GAME.selected_back.effect.config.ttr_red then
					if context.joker_main and G.GAME.current_round.discards_left == card.ability.extra.d_remaining then
						return{
							message = localize{type='variable',key='a_xmult',vars={4}},
                        	Xmult_mod = 4
						}
					end
				end
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_mystic_summit_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("j_burglar", {
			calculate = function(self, card, context)
				if context.setting_blind and not context.blueprint then
					return {
						G.E_MANAGER:add_event(Event({func = function()
							if G.GAME.current_round.discards_left > 0 then
								ease_hands_played(math.floor((G.GAME.current_round.discards_left)/2))
								ease_discard(-G.GAME.current_round.discards_left, nil, true)
							end
						return true end }))
					}
				end		
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					local hands_gained
					hands_gained = math.floor((G.GAME.current_round.discards_left)/2)
					return {key = 'j_burglar_red', vars = {hands_gained}}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Joker:take_ownership("yorick", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'j_yorick_red'}
				end
			end,
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra.xmult = 1
					card.ability.extra.discards = 15
					card.ability.yorick_discards = 15
				end
			end,
			unlocked = true,
			discovered = true,
		})
		
		SMODS.Voucher:take_ownership("grabber", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_boss_hands_perm = G.GAME.eor_boss_hands_perm + 1
			end,	
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_grabber_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Voucher:take_ownership("nacho_tong", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_normal_hands_perm = G.GAME.eor_normal_hands_perm + 1
			end,	
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_nacho_tong_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Voucher:take_ownership("wasteful", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_boss_discards_perm = G.GAME.eor_boss_discards_perm + 1
			end,	
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_wasteful_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		SMODS.Voucher:take_ownership("recyclomancy", {
			set_ability = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then
					card.ability.extra = 0
				end
			end,
			redeem = function(self)
				G.GAME.eor_normal_discards_perm = G.GAME.eor_normal_discards_perm + 1
			end,
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'v_recyclomancy_red'}
				end
			end,
			unlocked = true,
			discovered = true,
		})
		
		SMODS.Blind:take_ownership("water", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_water_red'}
				end
			end,
			collection_loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_water_red'}
				end
			end,
			set_blind = function(self,card)
				G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + G.GAME.current_round.discards_left - 2
			end,
			disable = function(self)
				ease_hands_played(self.discards_sub)
				G.GAME.eor_boss_discards_temp = 0
			end,
			discovered = true,
			defeated = true
		})
		SMODS.Blind:take_ownership("needle", {
			loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_needle_red'}
				end
			end,
			collection_loc_vars = function(self, card)
				if G.GAME.selected_back.effect.config.ttr_red then 
					return {key = 'bl_needle_red'}
				end
			end,
			set_blind = function(self,card)
				if not G.GAME.blind.disabled then 
					G.GAME.eor_boss_hands_temp = G.GAME.eor_boss_hands_temp + G.GAME.current_round.hands_left - 3
				end
			end,
			disable = function(self,card)
				ease_hands_played(self.hands_sub)
				G.GAME.eor_boss_hands_temp = 0
			end,
			
			discovered = true,
			defeated = true
		})
	end,
	calculate = function(self, card, context)
		boss_hands = G.GAME.eor_boss_hands_perm +G.GAME.eor_boss_hands_temp
		boss_discards = G.GAME.eor_boss_discards_perm +G.GAME.eor_boss_discards_temp
		normal_hands = G.GAME.eor_normal_hands_perm +G.GAME.eor_normal_hands_temp
		normal_discards = G.GAME.eor_normal_discards_perm +G.GAME.eor_normal_discards_temp
		local megapacks = {
			p_arcana_mega_1 = true,
			p_arcana_mega_2 = true,
			p_celestial_mega_1 = true,
			p_celestial_mega_2 = true,
			p_spectral_mega_1 = true,
			p_standard_mega_1 = true,
			p_standard_mega_2 = true,
			p_buffoon_mega_1 = true,
		}
		if context.buying_card or context.open_booster or context.reroll_shop then
			G.GAME.selected_back.effect.config.cards_bought = G.GAME.selected_back.effect.config.cards_bought + 1
		end
		if context.ending_shop then
			if G.GAME.selected_back.effect.config.cards_bought == 0 then
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(2)
					ease_discard(2)
				return true end }))
			else
				G.GAME.selected_back.effect.config.cards_bought = 0
			end
		end
		print(G.GAME.selected_back.effect.config.cards_bought)
		if context.selling_card then
			if context.card.ability.set == "Joker" then
				if context.card.config.center.rarity == 3 then
					G.E_MANAGER:add_event(Event({func = function()
						ease_hands_played(1)
					return true end }))
				else 
					G.E_MANAGER:add_event(Event({func = function()
						ease_discard(1)
					return true end }))
				end
			end
		end
		if context.skipping_booster then
			if megapacks[SMODS.OPENED_BOOSTER.config.center.key] then
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(1)
				return true end }))
			else
				G.E_MANAGER:add_event(Event({func = function()
					ease_discard(1)
				return true end }))
			end
		end
		if context.skip_blind then 
			G.E_MANAGER:add_event(Event({func = function()
				ease_hands_played(1)
			return true end }))
		end
	
		if context.end_of_round and G.GAME.last_blind.boss and not context.repetition and not context.individual then
			if G.GAME.current_round.hands_played == 1 then	
				G.GAME.eor_boss_hands_temp = G.GAME.eor_boss_hands_temp + 1
				boss_hands = G.GAME.eor_boss_hands_perm + G.GAME.eor_boss_hands_temp
			end
			if G.GAME.current_round.discards_used == 0 then
				G.GAME.eor_boss_discards_temp = G.GAME.eor_boss_discards_temp + 2
				boss_discards = G.GAME.eor_boss_discards_perm + G.GAME.eor_boss_discards_temp
			end
		end
		if context.end_of_round and G.GAME.current_round.hands_left == 0 and not context.repetition and not context.individual then
			if G.GAME.last_blind.boss then	
				G.GAME.eor_boss_hands_temp = G.GAME.eor_boss_hands_temp + 2
				boss_hands = G.GAME.eor_boss_hands_perm + G.GAME.eor_boss_hands_temp
			else 
				G.GAME.eor_normal_hands_temp = G.GAME.eor_normal_hands_temp + 2
				normal_hands = G.GAME.eor_normal_hands_perm + G.GAME.eor_normal_hands_temp
			end
		end
		if context.end_of_round and (boss_discards > 0 or normal_discards > 0) and not context.repetition and not context.individual then
			if G.GAME.last_blind.boss then
				G.E_MANAGER:add_event(Event({func = function()
					ease_discard(boss_discards)
					G.GAME.eor_boss_discards_temp = 0
				return true end }))
			else
				G.E_MANAGER:add_event(Event({func = function()
					ease_discard(normal_discards)
					G.GAME.eor_normal_discards_temp = 0
				return true end }))
			end	
		end	
		if context.end_of_round and (boss_hands > 0 or normal_hands > 0) and not context.repetition and not context.individual then
			if G.GAME.last_blind.boss then
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(boss_hands)
					G.GAME.eor_boss_hands_temp = 0
				return true end }))
			else
				G.E_MANAGER:add_event(Event({func = function()
					ease_hands_played(normal_hands)
					G.GAME.eor_normal_hands_temp = 0
				return true end }))
			end	
		end	
	end,
	omit = true
}

function G.UIDEF.deck_gimmicks()
	local card = Card(G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h, G.CARD_W*1.2, G.CARD_H*1.2, pseudorandom_element(G.P_CARDS), G.P_CENTERS.c_base, {bypass_back = G.GAME.selected_back.effect.center.pos, playing_card = 10, viewed_back = true})
    card.sprite_facing = 'back'
    card.facing = 'back'
	local actions_data = {
    { label = "Selling a Joker:            ", hands = 0, discards = 1, subtext_discards = "(+1 hand if Rare)" },
    { label = "Skipping a Booster:            ", hands = 0, discards = 1, subtext_discards = "(+1 hand if Mega)" },
    { label = "Skipping a Blind:                ", hands = 1, discards = 0, },
    { label = "Leaving the Shop without buying anything:", hands = 2, discards = 2 },
    { label = "Beating a Boss Blind in one hand:", hands = 1, discards = 0 },
    { label = "Beating a Boss Blind without discarding:", hands = 0, discards = 2 },
	{ label = "Beating a Blind with 0 hands remaining:", hands = 2, discards = 0 },
  }

  local actions_list = {}
  for _, action in ipairs(actions_data) do
    local hands_text = action.hands > 0 and "+" .. action.hands .. " " .. localize('k_hud_hands') or nil
    local discards_text = action.discards > 0 and "+" .. action.discards .. " " .. localize('k_hud_discards') or nil
    local subtext_hands = action.subtext_hands and { n = G.UIT.T, config = { text = action.subtext_hands, scale = 0.20, colour = G.C.ORANGE, shadow = true } } or nil
      local subtext_discards = action.subtext_discards and { n = G.UIT.T, config = { text = action.subtext_discards, scale = 0.20, colour = G.C.ORANGE, shadow = true } } or nil


    actions_list[#actions_list+1] = {
      n = G.UIT.R,
      config = { align = "cm", padding = 0.2 },
      nodes = {
        {
          n = G.UIT.C,
          config = { align = 'cl', minw = 1, maxw = 4 },
          nodes = {
            { n = G.UIT.T, config = { text = action.label .. "", scale = 0.35, colour = G.C.WHITE } },
          },
        },
        {
          n = G.UIT.C,
          config = { align = 'cr', minw = 4, padding = 0.1, maxw = 5 },
          nodes = {
            hands_text and {
              n = G.UIT.C, config = {align = 'cm'},
              nodes = {
                {
                  n = G.UIT.C, config = {align = 'cm'},
                  nodes = {
                    { n = G.UIT.T, config = { text = hands_text, scale = 0.35, colour = G.C.BLUE, shadow = true } },
                    subtext_hands,
                  }
                }
              }
            } or nil,
            discards_text and {
              n = G.UIT.C, config = {align = 'cm'},
              nodes = {
                {
                  n = G.UIT.C, config = {align = 'cm'},
                  nodes = {
                    (hands_text and discards_text) and { n = G.UIT.T, config = { text = " and ", scale = 0.35, colour = G.C.WHITE, shadow = true } } or nil,
                    { n = G.UIT.T, config = { text = discards_text, scale = 0.35, colour = G.C.RED, shadow = true } },
                    subtext_discards,
                  }
                }
              }
            } or nil,
            
          },
        },
      },
    }
  end
	return
	{n = G.UIT.ROOT, config = {r = 0.1, minw = 10, minh = 8, align = "cr", padding = 0.2, colour = G.C.BLACK}, nodes = {
		{n = G.UIT.C, config = {r = 0.1, minw = 1, minh = 8, align = "cr", padding = 0.05, colour = G.C.L_BLACK}, nodes = {
			{n=G.UIT.C, config={align = "cm", minw = 1, padding = 0.05, r = 0.1, colour = G.C.L_BLACK, emboss = 0.0}, nodes={
				{n=G.UIT.R, config={align = "tm", minw = 2.5, padding = 0.05, r = 0.1, colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), emboss = 0.05}, nodes={
					{n=G.UIT.R, config={align = "tm", minw = 2.5, padding = 0.05, r = 0.1, colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), emboss = 0.0}, nodes={
						{n=G.UIT.O, config={object = DynaText({string = G.GAME.selected_back.loc_name, colours = {G.C.WHITE}, bump = true, rotate = true, shadow = true, scale = 0.6 - string.len(G.GAME.selected_back.loc_name)*0.01})}},
					}},
					{n=G.UIT.R, config={align = "tm", minw = 2.5, padding = 0.05, r = 0.1, colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), emboss = 0.0}, nodes={
						{n=G.UIT.O, config={object = card}}
					}},	
				}},
				{n=G.UIT.R, config={align = "cm", r = 0.1, padding = 0.05, minw = 2.5, minh = 1.3, colour = G.C.WHITE, emboss = 0.05}, nodes={
					{n=G.UIT.O, config={object = UIBox{
					  definition = G.GAME.selected_back:generate_UI(nil,0.7, 0.5, G.GAME.challenge),
					  config = {offset = {x=0,y=0}}
					}}}
				}}
			}}
		}},
		{n = G.UIT.C, config = {align = 'cr', padding = 0.15}, nodes = actions_list },
	}}
end
Tattered.add_b_side("b_" .. "red", "b_tattered_" .. "red")
>>>>>>> b27156c (idk what i'm doing)
