process = input

# see https://github.com/JamesHarrison/conduit/blob/master/conduit.liq for where
# I got some of the comments in here from

# Gate the input for starters, stops noise from clobbering things in silent periods.
process = ladspa.gate(process, threshold = -60.0, attack = 0.15, hold = 1.0, decay = 200.0, range = -25.0)

# Limiter, this one's a scaling one which limits nicely and without artefacting mostly
process = ladspa.tap_limiter(process, limit_level = -0.5)
# And a final limiter - this should never really get hit, but stops anything nasty hitting the DAC. Highly peak-focused.
process = limit(process, threshold = -0.2, attack = 2.0, release = 25.0, rms_window = 0.02)

output = process
