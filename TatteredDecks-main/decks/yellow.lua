SMODS.Back{
	
	name = "Tattered Yellow Deck",
	key = "yellow",
    atlas = "b_side_atlas",
	pos = {x = 2, y = 0},
	config = {b_side = true},
	loc_txt = {
		name = "Tattered Yellow Deck",
		text ={
			"???"
		},
    },
	loc_vars = function(self)
        return {}
	end,
	apply = function()
	end,
	omit = true
}
Tattered.add_b_side("b_" .. "yellow", "b_tattered_" .. "yellow")