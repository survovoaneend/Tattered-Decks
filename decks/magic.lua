SMODS.Back{
	name = "Tattered Magic Deck",
	key = "magic",
    atlas = "b_side_atlas",
	pos = {x = 0, y = 1},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Magic Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "magic", "b_tattered_" .. "magic")