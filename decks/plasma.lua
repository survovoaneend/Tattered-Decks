
SMODS.Back{
	name = "Tattered Plasma Deck",
	key = "plasma",
    atlas = "b_side_atlas",
	pos = {x = 3, y = 2},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Plasma Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "plasma", "b_tattered_" .. "plasma")