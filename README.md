# WebMVVM

## How to create a new `Viewable` object

**DEPRECATED**

Start off by importing the View and Viewable modules from WebMVVM, along with Typeable from Data.

```haskell
import Data.Typeable
import WebMVVM.WebMVVM (View, Viewable)
```

Create your new Data type to be used as a view and make it an instance of the `View` typeclass. Make sure that it derives `Typeable`. The operator `(</>) :: a -> [Style] -> a` is used as a way to apply styles defined in `Style` to your data and the function `render :: a -> String` is a way to define how the html engine will render your data. 

```haskell
data NewDataType = {- Fields -} deriving (Typeable)
instance View NewDataType where
    a </> b = {- Apply style to your data type -}
    render a = {- Print your data type as html string -}
```

For example, the `TextView` that is used for rendering basic text is defined as 

```haskell
data TextView = TextView String [Style] deriving (Typeable)
instance View TextView where 
    (TextView s c) </> c2 = TextView s (c ++ c2)
    render (TextView s c) = "<span style='" ++ showStyle c ++ "'>" ++ s ++ "</span>"
```

Once that is done, create a function that reduces the intialization of your View to only the absolutely necessary items and converts your `View` into a `Viewable`. We do this because:

1. Minimizing the function reduces the screen clutter by only allowing the necessary input,
2. Converting from `View` to `Viewable` allows for a heterogeneous tree structure for the HTML elements. This is covered [here](https://wiki.haskell.org/Heterogenous_collections).

The function should be similar to

```haskell
dataType :: {- Minimal Inputs -} -> Viewable
dataType {- Minimal Inputs -} = pack $ NewDataType {- Minimal Inputs combined with default fields -}
```

The key word in the last code block is `pack` since this keyword takes `View -> Viewable`. The only issue with this format is once a Viewable is packed, it can not be unpacked, so any transformations from that point on will solely have to be visual. Because of this, it is important that you leave data transformations in the logic layer.

Once again, we use the `TextView` as an example:

```haskell
text :: String -> Viewable 
text s = pack $ TextView s []
```

`text` takes a `String` as input and creates a `Viewable TextView` out of it.