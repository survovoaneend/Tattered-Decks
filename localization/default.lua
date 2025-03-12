
return {
    descriptions = {
        Joker = {
            --T. Red
            j_drunkard_red = {
                name = "Drunkard",
                text = {
                    "{C:red}+1{} discard when {C:attention}boss blind{}",
                    "is defeated"
            },
            },
            j_troubadour_red = {
                name = "Troubadour",
                text = {
                    "{C:attention}+2{} hand size,",
                    "{C:green}#1# in 4{} chance for {C:blue}hands{}",
                    "to cost {C:attention}1{} additional hand"
                }
            },
            j_merry_andy_red = {
                name = "Merry Andy",
                text = {
                    "{C:attention}-1{} hand size",
                    "If less than {C:attention}3{} {C:red}discards{}",
                    "are used this round, {C:attention}refund{}",
                    "them at {C:attention}end of round{}"
                }
            },
            j_delayed_grat_red = {
                name = "Delayed Gratification",
                text = {
                    "Earn {C:money}$#1#{} if no {C:attention}discards{}",
                    "are used by end of",
                    "the round"
                }
            },
            j_dusk_red = {
                name = "Dusk",
                text = {
                    "Retrigger all played",
                    "cards after the {C:attention}third{}",
                    "{C:attention}hand{} of round",
                    "{C:inactive}#2#{}"
                }
            },
            j_acrobat_red = {
                name = "Acrobat",
                text = {
                    "{X:red,C:white} X#1# {} Mult after the {C:attention}third{}",
                    "{C:attention}hand{} of round",
                    "{C:inactive}#2#{}"
                }
            },
            j_mystic_summit_red = {
                name = "Mystic Summit",
                text = {
                    "{X:red,C:white} X4 {} Mult when {C:attention}0{}",
                    "discards remaining"
                }
            },
            j_burglar_red = {
                name = "Burglar",
                text = {
                    "{C:blue}+1{} hand upon defeating a",
                    "{C:attention}blind{}. Discards are {C:attention}disabled{}",
                    "when selecting blind."
                }
            },
            j_yorick_red = {
                name = "Yorick",
                text = {
                    "This Joker gains",
                    "{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}",
                    "cards discarded",
                    "{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)"
                }
            },
            --T. Yellow
            j_delayed_grat_yellow = {
                name = "Delayed Gratification",
                text = {
                    "Earn {X:money,C:white}+$0.1X{} per {C:attention}discard{} if",
                    "no discards are used",
                    "by end of the round"
                }
            },
            j_cloud_9_yellow = {
                name = "Cloud 9",
                text = {
                    "Earn {X:money,C:white}$0.1X{} for each",
                    "{C:attention}9{} in your {C:attention}full deck",
                    "at end of round",
                    "{C:inactive}(Currently {X:money,C:white}+$#2#X{}{C:inactive})"
                }
            },
            j_golden_yellow = {
                name = "Golden Joker",
                text = {
                    "Earn {X:money,C:white}$0.3X{} at",
                    "end of round"
                }
            },
            j_rocket_yellow = {
                name = "Rocket",
                text = {
                    "Earn {X:money,C:white}$#1#X{} at end of round",
                    "Payout increases by {X:money,C:white}$0.1X{}",
                    "when {C:attention}Boss Blind{} is defeated",
                }
            },
            j_satellite_yellow = {
                name = "Satellite",
                text = {
                    "Earn {X:money,C:white}$0.1X{} at end of",
                    "round per unique {C:planet}Planet",
                    "card used this run",
                    "{C:inactive}(Currently {X:money,C:white}+$#2#X{C:inactive})"
                }
            },


        },
        Voucher = {
            --T. Red
            v_grabber_red = {
                name = "Grabber",
                text = {
                    "{C:blue}+1{} hand upon defeating the",
                    "the {C:attention}boss blind{}"
                }
            },
            v_nacho_tong_red = {
                name = "Nacho Tong",
                text = {
                    "{C:blue}+1{} hand upon defeating any",
                    "{C:attention}non-boss blind{}"
                }
            },
            v_wasteful_red = {
                name = "Wasteful",
                text = {
                    "{C:red}+1{} discard upon defeating",
                    "the {C:attention}boss blind{}"
                }
            },
            v_recyclomancy_red = {
                name = "Wasteful",
                text = {
                    "{C:red}+1{} discard upon defeating any",
                    "{C:attention}non-boss blind{}"
                }
            }
        },
        Spectral = {
            --T. Yellow
            c_wraith_yellow = {
                name = "Wraith",
                text = {
                    "Creates a random",
                    "{C:red}Rare{C:attention} Joker{},",
                    "sets money to {C:money}$1"
                }
            }
        },
        Blind = {
            --T. Red
            bl_water_red = {
                name = "The Water",
                text = {
                    "Temporarily set",
                    "discards to 0"
                }
            },
            bl_needle_red = {
                name = "The Needle",
                text = {
                    "Temporarily set",
                    "hands to 1"
                }
            },
            bl_ox_yellow = {
                name = "The Ox",
                text = {
                    "Playing a #1#",
                    "sets money to $1"
                }
            }
        },
        misc = {
            v_dictionary = {
                red_remaining_hand_money = "Remaining Hands ($1 per 6)"
            }
        }
    },
}
