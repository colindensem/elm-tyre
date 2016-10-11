module Home exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


-- model


type alias Model =
    {}


initModel : Model
initModel =
    {}



-- update


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Home" ]
        , hr [] []
        , h4 [] [ text "Home Model:" ]
        , p [] [ text <| toString model ]
        ]
