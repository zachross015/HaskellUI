{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module HaskellUI.View 
    (
    View (..), 
    DOMTree (..),
    DOMMeta (..),

    hstack,
    vstack,
    text
    ) where

import HaskellUI.Color 
import HaskellUI.WebMeasurement
import HaskellUI.Property

import Data.Char (toLower)
import Data.Typeable

class View a where
    (<|) :: a -> [Property] -> a
    render :: a -> String

data DOMMeta = DOMMeta {
    tag :: String,
    properties :: [Property]
}

renderTag :: DOMMeta -> String -> String 
renderTag (DOMMeta t p) a = "<" 
                          ++ t
                          ++ " " 
                          ++ (renderProperties p) 
                          ++ ">"
                          ++ a
                          ++ "</"
                          ++ t
                          ++ ">" 

data DOMTree a = Viewable DOMMeta a
               | ViewableSequence DOMMeta [DOMTree a]
               | Empty

instance (Semigroup x) => Semigroup (DOMTree x) where 
    (<>) a Empty = a
    (<>) Empty b = b

    (<>) (ViewableSequence m1 a) (ViewableSequence m2 b) = ViewableSequence (DOMMeta "div" []) [(ViewableSequence m1 a), (ViewableSequence m2 b)]
    (<>) (ViewableSequence m a) b = ViewableSequence m (a ++ [b])
    (<>) a (ViewableSequence m b) = (ViewableSequence m (a:b))
    (<>) a b = ViewableSequence (DOMMeta "div" []) [a, b]

instance (Semigroup x) => Monoid (DOMTree x) where 
    mempty = Empty

instance (View a) => View (DOMTree a) where 
    (Viewable (DOMMeta t p) a) <| c = Viewable (DOMMeta t (p ++ c)) a
    (ViewableSequence (DOMMeta t p) a) <| c = ViewableSequence (DOMMeta t (p ++ c)) a
    render (Viewable d a) = renderTag d (render a)
    render (ViewableSequence d a) = renderTag d $ concatMap render a

instance View String where 
    s <| _ = s
    render s = s

hstack :: (View a) => [DOMTree a] -> DOMTree a
hstack x = ViewableSequence (DOMMeta "div" [className "hstack"]) (map (<|[className "hstack-inner"]) x)

vstack :: (View a) => [DOMTree a] -> DOMTree a
vstack x = ViewableSequence (DOMMeta "div" [className "vstack"]) (map (<|[className "vstack-inner"]) x)

text :: String -> DOMTree String
text s = Viewable (DOMMeta "span" []) s