SMODS.Back{
	name = "Tattered Green Deck",
	key = "green",
    atlas = "b_side_atlas",
	pos = {x = 3, y = 0},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Green Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "green", "b_tattered_" .. "green")