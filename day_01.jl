### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ a33390bc-8b86-11eb-2dec-9341362cee8f
md"""
# Day 1: The Tyranny of the Rocket Equation
"""

# ╔═╡ f644a064-8b88-11eb-0504-834fc074480f
md"""
## Parsing Input Data

Take the raw input and parse it into an array of Ints
"""

# ╔═╡ ca56e2c8-8b86-11eb-2095-912b847cf18b
md"""
## Part 1

The Elves quickly load you into a spacecraft and prepare to launch.

At the first Go / No Go poll, every Elf is Go until the Fuel Counter-Upper. They haven't determined the amount of fuel required yet.

Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

For example:

 - For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
 - For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
 - For a mass of 1969, the fuel required is 654.
 - For a mass of 100756, the fuel required is 33583.

The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel needed for the mass of each module (your puzzle input), then add together all the fuel values.

What is the sum of the fuel requirements for all of the modules on your spacecraft?
"""

# ╔═╡ 58f1cbba-8be3-11eb-2f36-4bdaeebd4081
md"""
### Definitions

Calculate the fuel needed by floor dividing the mass by three and subtracting two:
"""

# ╔═╡ 28b8a4c4-8be2-11eb-1167-459e87f0a1c1
# Calculate fuel for a mass
function fuel_for_mass(mass)
	div(mass, 3) - 2
end

# ╔═╡ 8868088c-8be3-11eb-21ac-4da3c4e7f6a8
md"Test the function using the example inputs:"

# ╔═╡ a576df08-8be2-11eb-3eda-9be9619494e0
# Test with example inputs
begin
	@assert fuel_for_mass(12)     == 2
	@assert fuel_for_mass(14)     == 2
	@assert fuel_for_mass(1969)   == 654
	@assert fuel_for_mass(100756) == 33583
end

# ╔═╡ ae62069e-8be3-11eb-36c4-ffa83907437a
md"""
### Solution

Calculate the mass of each module and sum them:
"""

# ╔═╡ f46dbbc2-8be4-11eb-37ac-0136a0a217a5
md"""
## Part 2

During the second Go / No Go poll, the Elf in charge of the Rocket Equation Double-Checker stops the launch sequence. Apparently, you forgot to include additional fuel for the fuel you just added.

Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and subtract 2. However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any mass that would require negative fuel should instead be treated as if it requires zero fuel; the remaining mass, if any, is instead handled by wishing really hard, which has no mass and is outside the scope of this calculation.

So, for each module mass, calculate its fuel and add it to the total. Then, treat the fuel amount you just calculated as the input mass and repeat the process, continuing until a fuel requirement is zero or negative. For example:

 - A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down is 0, which would call for a negative fuel), so the total fuel required is still just 2.
 - At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.
 - The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.

What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the mass of the added fuel? (Calculate the fuel requirements for each module separately, then add them all up at the end.)
"""

# ╔═╡ 43f9a618-8be5-11eb-1094-71aa51c21dcd
md"""
### Definitions

Calculate the fuel needed by floor dividing the mass by three and subtracting two, then recursivly calculate the fuel needed for each bit of fuel:
"""

# ╔═╡ 5483552e-8be5-11eb-3e81-d59914eea2de
# Calculate fuel for a mass, including the fuel needed for the fuel itself
function fuel_for_mass_including_fuel(mass)
	fuel = div(mass, 3) - 2
	if fuel <= 0
		0
	else
		fuel + fuel_for_mass_including_fuel(fuel)
	end
end

# ╔═╡ 9c133b5c-8be5-11eb-28cc-ef62d6de30b9
# Test with example inputs
begin
	@assert fuel_for_mass_including_fuel(12)     == 2
	@assert fuel_for_mass_including_fuel(14)     == 2
	@assert fuel_for_mass_including_fuel(1969)   == 966
	@assert fuel_for_mass_including_fuel(100756) == 50346
end

# ╔═╡ 88596a04-8be6-11eb-0d5f-1925f92b7d51
md"""
### Solution

Calculate the mass of each module and sum them:
"""

# ╔═╡ 40d1e416-8b89-11eb-0bd3-199a58d6e19f
md"## Raw Input String"

# ╔═╡ 7676b700-8b88-11eb-3db2-e3445de9bed2
# Our Input Data
raw_input = """128270
147113
61335
78766
119452
116991
70640
145446
117606
135046
70489
131072
67955
66424
126450
101418
90225
66004
136510
61695
143880
53648
58699
119214
83838
95895
66388
66755
120223
79310
93828
136686
108958
140752
85343
103800
126602
147726
88228
83380
77877
61922
75448
67095
60888
136692
63271
113742
68854
86904
110243
104642
141854
71205
76729
138540
134142
62517
63306
71363
126146
74749
76716
59135
62449
110575
134030
84072
122698
96891
69976
94501
149180
57944
64873
68192
138238
119185
137570
79274
111040
142586
120872
63586
78628
122704
147951
102593
105562
55180
64450
87466
112522
60000
149885
52154
80633
61867
86380
136024
"""

# ╔═╡ 0261447e-8b89-11eb-0279-dd5ae4cca884
input = begin
	input_lines = split(raw_input, "\n", keepempty=false)
	map(x -> parse(Int, x), input_lines)
end

# ╔═╡ cc050e14-8be3-11eb-06d5-83d04385abf7
begin
	local fuel_needed = 0
	for module_mass in input
		fuel_needed += fuel_for_mass(module_mass)
	end
	fuel_needed
end

# ╔═╡ 90156874-8be6-11eb-247d-792708d08f9b
begin
	local fuel_needed_with_fuel = 0
	for module_mass in input
		fuel_needed_with_fuel += fuel_for_mass_including_fuel(module_mass)
	end
	fuel_needed_with_fuel
end

# ╔═╡ Cell order:
# ╟─a33390bc-8b86-11eb-2dec-9341362cee8f
# ╟─f644a064-8b88-11eb-0504-834fc074480f
# ╠═0261447e-8b89-11eb-0279-dd5ae4cca884
# ╟─ca56e2c8-8b86-11eb-2095-912b847cf18b
# ╟─58f1cbba-8be3-11eb-2f36-4bdaeebd4081
# ╠═28b8a4c4-8be2-11eb-1167-459e87f0a1c1
# ╟─8868088c-8be3-11eb-21ac-4da3c4e7f6a8
# ╠═a576df08-8be2-11eb-3eda-9be9619494e0
# ╟─ae62069e-8be3-11eb-36c4-ffa83907437a
# ╠═cc050e14-8be3-11eb-06d5-83d04385abf7
# ╟─f46dbbc2-8be4-11eb-37ac-0136a0a217a5
# ╟─43f9a618-8be5-11eb-1094-71aa51c21dcd
# ╠═5483552e-8be5-11eb-3e81-d59914eea2de
# ╠═9c133b5c-8be5-11eb-28cc-ef62d6de30b9
# ╟─88596a04-8be6-11eb-0d5f-1925f92b7d51
# ╠═90156874-8be6-11eb-247d-792708d08f9b
# ╟─40d1e416-8b89-11eb-0bd3-199a58d6e19f
# ╟─7676b700-8b88-11eb-3db2-e3445de9bed2
