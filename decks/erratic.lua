
SMODS.Back{
	name = "Tattered Erratic Deck",
	key = "erratic",
    atlas = "b_side_atlas",
	pos = {x = 4, y = 2},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Erratic Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "erratic", "b_tattered_" .. "erratic")