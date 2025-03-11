
SMODS.Back{
	name = "Tattered Painted Deck",
	key = "painted",
    atlas = "b_side_atlas",
	pos = {x = 1, y = 2},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Painted Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "painted", "b_tattered_" .. "painted")