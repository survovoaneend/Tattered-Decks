
SMODS.Back{
	name = "Tattered Green Deck",
	key = "black",
    atlas = "b_side_atlas",
	pos = {x = 4, y = 0},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Black Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}

Tattered.add_b_side("b_" .. "black", "b_tattered_" .. "black")