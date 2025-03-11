
SMODS.Back{
	name = "Tattered Checkered Deck",
	key = "checkered",
    atlas = "b_side_atlas",
	pos = {x = 4, y = 1},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Checkered Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}

Tattered.add_b_side("b_" .. "checkered", "b_tattered_" .. "checkered")