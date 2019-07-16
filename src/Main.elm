module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html.Styled exposing (..)
import Page.Note
import Route
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view =
            \model ->
                { title = "ElmNote"
                , body = [ toUnstyled <| view model ]
                }
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = \_ -> NoOp
        , onUrlRequest = \_ -> NoOp
        }



-- MODEL


type Model
    = NoteModel Page.Note.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    case Route.fromUrl url |> Maybe.withDefault Route.Note of
        Route.Note ->
            Page.Note.init
                |> wrap ToNote NoteModel


type Msg
    = ToNote Page.Note.Message
    | SaveNote Page.Note.Message
    | EditNote Page.Note.Message
    | DeleteNote Page.Note.Message
    | NoOp



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( ToNote childMessage, NoteModel childModel ) ->
            Page.Note.update childMessage childModel
                |> wrap ToNote NoteModel

        _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        NoteModel note ->
            Sub.map ToNote (Page.Note.subscriptions note)



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        NoteModel childModel ->
            Page.Note.view childModel
                |> map ToNote



-- UTIL


wrap : (childMessage -> Msg) -> (childModel -> Model) -> ( childModel, Cmd childMessage ) -> ( Model, Cmd Msg )
wrap toMessage toModel ( childModel, childCmd ) =
    ( toModel childModel, Cmd.map toMessage childCmd )
