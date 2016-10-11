module Tyre exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String


-- model


type alias Model =
    { currentTyre : CurrentTyre
    }


type alias Tyre =
    { width : Int
    , profile : Int
    , rim : Int
    , sidewall : Float
    , diameter : Float
    , radius : Float
    , circumference : Float
    }


type alias CurrentTyre =
    Tyre


initModel : Model
initModel =
    { currentTyre =
        { width = 0
        , profile = 0
        , rim = 0
        , sidewall = 0.0
        , diameter = 0.0
        , radius = 0.0
        , circumference = 0.0
        }
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
                    { model | currentTyre = setWidth model.currentTyre val }

                -- Notify the user, or simply ignore the value
                Err err ->
                    model

        ProfileInput val ->
            case String.toInt val of
                Ok val ->
                    { model | currentTyre = setProfile model.currentTyre val }

                -- Notify the user, or simply ignore the value
                Err err ->
                    model

        RimInput val ->
            case String.toInt val of
                Ok val ->
                    { model | currentTyre = setRim model.currentTyre val }

                -- Notify the user, or simply ignore the value
                Err err ->
                    model


setWidth : Tyre -> Int -> Tyre
setWidth t width =
    let
        diameter =
            calc_diameter t.rim t.sidewall

        sidewall =
            calc_sidewall width t.profile

        radius =
            calc_radius diameter
    in
        { t
            | width = width
            , sidewall = sidewall
            , diameter = diameter
            , radius = radius
            , circumference = calc_circumference radius
        }


setProfile : Tyre -> Int -> Tyre
setProfile t profile =
    let
        diameter =
            calc_diameter t.rim t.sidewall

        sidewall =
            calc_sidewall t.width profile

        radius =
            calc_radius diameter
    in
        { t
            | profile = profile
            , sidewall = sidewall
            , diameter = diameter
            , radius = radius
            , circumference = calc_circumference radius
        }


setRim : Tyre -> Int -> Tyre
setRim t rim =
    let
        diameter =
            calc_diameter rim sidewall

        sidewall =
            calc_sidewall t.width t.profile

        radius =
            calc_radius diameter
    in
        { t
            | rim = rim
            , sidewall = sidewall
            , diameter = diameter
            , radius = radius
            , circumference = calc_circumference radius
        }



-- view
-- this.sidewall  = Math.round(this.width*(this.profile/100)*100)/100;
-- this.diameter  = Math.round(((this.rim*25.4)+(2*this.sidewall))*100)/100;
-- this.radius    = (this.diameter / 2);
-- this.circumference = Math.round(((Math.PI)*this.diameter)*100)/100;
-- this.rollingCircumference = (0.96 * Math.PI * this.diameter).toFixed(2);
-- this.revs       = (1609344/this.rollingCircumference).toFixed(2);
--


calc_revs : Float -> Float
calc_revs rollingCirc =
    1609344 / rollingCirc


calc_rollingCirc : Int -> Int -> Int -> Float
calc_rollingCirc rim width profile =
    let
        rolling_rad =
            (25.4 * toFloat (rim) / 2) + (0.923 * toFloat (width)) * (toFloat (profile) / 100)
    in
        (2 * Basics.pi * rolling_rad)



-- 0.96 * Basics.pi * dia


calc_circumference : Float -> Float
calc_circumference radius =
    (2 * Basics.pi * radius)


calc_radius : Float -> Float
calc_radius diameter =
    diameter / 2


calc_diameter : Int -> Float -> Float
calc_diameter rim sidewall =
    ((((toFloat rim * 25.4) + (2 * sidewall)) * 100) / 100)


calc_sidewall : Int -> Int -> Float
calc_sidewall width profile =
    ((toFloat width * ((toFloat profile / 100) * 100)) / 100)


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Tyre Wizard" ]
        , Html.form []
            [ p []
                [ text "Current Tyre" ]
            , input
                [ type' "number"
                , onInput WidthInput
                , placeholder "width"
                ]
                []
            , input
                [ type' "number"
                , onInput ProfileInput
                , placeholder "profile"
                ]
                []
            , input
                [ type' "number"
                , onInput RimInput
                , placeholder "rim"
                ]
                []
            ]
        , p [] [ text ("Rolling Circ.  " ++ (toString (calc_rollingCirc model.currentTyre.rim model.currentTyre.width model.currentTyre.profile))) ]
        , p [] [ text ("Revs.  " ++ (toString (calc_revs (calc_rollingCirc model.currentTyre.rim model.currentTyre.width model.currentTyre.profile)))) ]
        , hr [] []
        , h4 [] [ text "Tyre Model:" ]
        , p [] [ text <| toString model ]
        ]
