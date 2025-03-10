<<<<<<< HEAD
SMODS.Back{
	name = "Tattered Ghost Deck",
	key = "abandoned",
    atlas = "b_side_atlas",
	pos = {x = 3, y = 1},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Abandoned Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
=======
SMODS.Back{
	name = "Tattered Ghost Deck",
	key = "abandoned",
    atlas = "b_side_atlas",
	pos = {x = 3, y = 1},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Abandoned Deck",
		text ={
			"???",
		},
    },
	apply = function()
	end,
	omit = true
}
>>>>>>> b27156c (idk what i'm doing)
Tattered.add_b_side("b_" .. "abandoned", "b_tattered_" .. "abandoned")