module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import Home
import Tyre


-- model


type alias Model =
    { page : Page
    , home : Home.Model
    , tyre : Tyre.Model
    }


initModel : Model
initModel =
    { page = HomePage
    , home = Home.initModel
    , tyre = Tyre.initModel
    }


type Page
    = HomePage
    | TyrePage



--update


type Msg
    = ChangePage Page
    | HomeMsg Home.Msg
    | TyreMsg Tyre.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePage page ->
            { model | page = page }

        HomeMsg hoMsg ->
            { model | home = Home.update hoMsg model.home }

        TyreMsg tyMsg ->
            { model | tyre = Tyre.update tyMsg model.tyre }



-- view


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                HomePage ->
                    App.map HomeMsg
                        (Home.view model.home)

                TyrePage ->
                    App.map TyreMsg
                        (Tyre.view model.tyre)
    in
        div []
            [ div []
                [ a
                    [ href "#"
                    , onClick (ChangePage HomePage)
                    ]
                    [ text "Home Page" ]
                , span [] [ text " | " ]
                , a
                    [ href "#"
                    , onClick (ChangePage TyrePage)
                    ]
                    [ text "Tyre Page" ]
                ]
            , hr [] []
            , page
            , hr [] []
            , h4 [] [ text "App Model:" ]
            , p [] [ text <| toString model ]
            ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
