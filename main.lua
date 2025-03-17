Tattered = SMODS.current_mod
function deck_select_confirm()

end

-- Definitions
Tattered.b_side_table = {}
Tattered.b_side_current = false
Tattered.load_table = {
	red = true,
    blue = true,
    yellow = true,
    green = true,
    black = true,
    magic = true,
    nebula = true,
	ghost = true,
	abandoned = true,
    checkered = true,
    zodiac = true,
	painted = true,
    anaglyph = true,
    plasma = true,
    erratic = true,
}
-- API
Tattered.add_b_side = function(deck_id, b_side_id)
	Tattered.b_side_table[deck_id] = b_side_id; Tattered.b_side_table[b_side_id] = deck_id
end

for k, v in pairs(Tattered.load_table) do
    if v then SMODS.load_file('decks/'..k..'.lua')() end
end

-- Util
function get_checkered_suit_rotation()
	local suits = {"Spades", "Hearts", "Clubs", "Diamonds"}
	for i, v in ipairs(SMODS.Suits) do
		if i < 5 then goto continue end
		suits[#suits+1] = v.key
		::continue::
	end
 	return suits
end

function find_in_list(list, target)
	for i, item in ipairs(list) do
		if item == target then
			return i
		end
	end
	return nil
end


--SMODS.Sound({
	--key = "music_tattered",
	--path = "music_tattered.mp3",
	--pitch = 1,
	--volume = 1,
	--select_music_track = function()
		--return on_b_sides()
	--end,
--})
-- Decks


SMODS.Atlas {
    key = "b_side_atlas",
    path = "b_sides.png",
    px = 71,
    py = 95
}
--to play music

G.FUNCS.apply_b_sides = function()
    for _, deck_area in ipairs(Galdur.run_setup.deck_select_areas) do
        if #deck_area.cards ~= 0 then
            local card = deck_area.cards[1]
            if Tattered.b_side_table[card.config.center.key] ~= nil then
                local center = G.P_CENTERS[Tattered.b_side_table[card.config.center.key]]
				local cards_to_remove = {}
        		for _, card in ipairs(deck_area.cards) do
           			 table.insert(cards_to_remove, card)
        		end
                G.E_MANAGER:add_event(Event({trigger = "immediate", blockable = false, func = function() 
                    for _, cards in ipairs(cards_to_remove) do
                        cards:remove()
                    end
                    return true
                end }))
                for _ = 1, Galdur.config.reduce and 1 or 10 do
                    G.E_MANAGER:add_event(Event({trigger = "after", blockable = false, func = function()
                        local new_card = Card(deck_area.T.x, deck_area.T.y, G.CARD_W, G.CARD_H, center, center, {galdur_back = Back(center), deck_select = 1})
                        new_card.deck_select_position = true
                        new_card.sprite_facing = "back"
                        new_card.facing = "back"
                        new_card.children.back = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[center.atlas or "centers"], center.pos)
                        new_card.children.back.states.hover = card.states.hover
                        new_card.children.back.states.click = card.states.click
                        new_card.children.back.states.drag = card.states.drag
                        new_card.children.back.states.collide.can = false
                        new_card.children.back:set_role({major = new_card, role_type = "Glued", draw_major = new_card})
                        deck_area:emplace(new_card)
                        return true
                    end}))
                end
            end
        end
    end
end
function on_b_sides()
	if Tattered.b_side_current == true then
		return true
	elseif Tattered.b_side_current == false then
		return false
	else 
		return false
	end
end
function custom_deck_select_page_deck()
    local page = deck_select_page_deck()
	local button_area = page.nodes[1].nodes[2].nodes[1].nodes[1]

	local switch_button = {n = G.UIT.R, config={align = "cm", padding = 0.15}, nodes = {
        {n=G.UIT.R, config = {maxw = 2.5, minw = 2.5, minh = 0.2, r = 0.1, hover = true, ref_value = 1, button = "flip_b_sides", colour = Tattered.badge_colour, align = "cm", emboss = 0.1}, nodes = {
            {n=G.UIT.T, config={text = "Tattered", scale = 0.4, colour = Tattered.badge_text_colour}}
        }}
    }}
	table.insert(button_area.nodes, 1, switch_button)
	if Tattered.b_side_current then

		G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            blockable = false,
            func = function()
                G.FUNCS.apply_b_sides()
                return true
            end
        }))
	end
	return page
end

G.FUNCS.flip_b_sides = function(e)
	stop_use()
	play_sound("gong", 0.5,1.0)
	play_sound("whoosh",0.5,1.0)
	play_sound("crumple1",0.5,1.0)
	
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = function()
			Tattered.b_side_current = not Tattered.b_side_current
			if G.OVERLAY_MENU then
				G.OVERLAY_MENU:set_role({xy_bond = 'Weak'})
			end
			return true
		end
	}))
	G.E_MANAGER:add_event(Event({
		trigger = 'ease',
		delay = 0.15,
		ease = 'quad', 
		ref_table = G.OVERLAY_MENU.alignment.offset,
		ref_value = 'y',
		ease_to = 20
	}))
	
	G.E_MANAGER:add_event(Event({
		trigger = 'ease',
		delay = 0.15, 
		ease = 'quad',
		ref_table = G.OVERLAY_MENU.alignment.offset,
		ref_value = 'y',
		ease_to = 0,
	}))




	G.FUNCS.apply_b_sides()
end


for _, args in ipairs(Galdur.pages_to_add) do
	if args.name == "gald_select_deck" then
		args.definition = custom_deck_select_page_deck
	end
end
local original_deck_page = G.FUNCS.change_deck_page
G.FUNCS.change_deck_page = function(args)
    original_deck_page(args)

        if Tattered.b_side_current then
			if Tattered.b_side_current then
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					blockable = false,
					func = function()
						G.FUNCS.apply_b_sides()
						return true
					end
				}))
			end
        end
end

