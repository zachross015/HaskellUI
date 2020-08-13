module HaskellUI.Color 
(RGB, black, blue, green, indigo, orange, pink, purple, red, teal, yellow) where

type RGB = (Int, Int, Int)

black :: RGB
black = (0,0,0)

blue :: RGB
blue = (0, 122, 255)

green :: RGB
green = (52, 199, 89)

indigo :: RGB
indigo = (88, 86, 214)

orange :: RGB
orange = (255, 149, 0)

pink :: RGB
pink = (255, 45, 85)

purple :: RGB
purple = (175, 82, 222)

red :: RGB
red = (255, 59, 48)

teal :: RGB
teal = (90, 200, 250)

yellow :: RGB
yellow = (255, 205, 0)