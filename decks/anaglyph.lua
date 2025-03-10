
SMODS.Back{
	name = "Tattered Anaglyph Deck",
	key = "anaglyph",
    atlas = "b_side_atlas",
	pos = {x = 2, y = 2},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Anaglyph Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}

Tattered.add_b_side("b_" .. "anaglyph", "b_tattered_" .. "anaglyph")