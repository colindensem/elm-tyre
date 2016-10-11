module Tyre exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String


-- model


type alias Model =
    { width : Int
    , profile : Int
    , rim : Int
    }


initModel : Model
initModel =
    { width = 0
    , profile = 0
    , rim = 0
    }



-- update


type Msg
    = WidthInput String
    | ProfileInput String
    | RimInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        WidthInput val ->
            case String.toInt val of
                Ok val ->
                    { model | width = val }

                -- Notify the user, or simply ignore the value
                Err err ->
                    model

        _ ->
            model



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Tyre" ]
        , Html.form []
            [ input
                [ type' "text"
                , onInput WidthInput
                , placeholder "width"
                ]
                []
            ]
        , hr [] []
        , h4 [] [ text "Tyre Model:" ]
        , p [] [ text <| toString model ]
        ]
