SMODS.Back{
	name = "Tattered Zodiac Deck",
	key = "zodiac",
    atlas = "b_side_atlas",
	pos = {x = 0, y = 2},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Zodiac Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "zodiac", "b_tattered_" .. "zodiac")