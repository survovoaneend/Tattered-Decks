
SMODS.Back{
	name = "Tattered Nebula Deck",
	key = "nebula",
    atlas = "b_side_atlas",
	pos = {x = 1, y = 1},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Nebula Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "nebula", "b_tattered_" .. "nebula")