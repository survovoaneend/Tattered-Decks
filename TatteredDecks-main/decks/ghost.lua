SMODS.Back{
	name = "Tattered Ghost Deck",
	key = "ghost",
    atlas = "b_side_atlas",
	pos = {x = 2, y = 1},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Ghost Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "ghost", "b_tattered_" .. "ghost")