
SMODS.Back{
	name = "Tattered Blue Deck",
	key = "blue",
    atlas = "b_side_atlas",
	pos = {x = 1, y = 0},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Blue Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "blue", "b_tattered_" .. "blue")