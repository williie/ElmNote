module Page.Note exposing (Message, Model, init, subscriptions, update, view)

import Css exposing (..)
import Html exposing (Html, button, div, input, label, li, ol, text)
import Html.Attributes exposing (class, value)
import Html.Events as A exposing (onClick, onInput)
import List.Extra as List


type alias Note =
    { title : String
    , content : String

    -- , noteId : Int
    }



--Model


type alias Model =
    { notes : List Note
    , selectedNote : Maybe ( Int, Note )
    }



--INIT


init : ( Model, Cmd Message )
init =
    ( { notes = []
      , selectedNote = Nothing
      }
    , Cmd.none
    )



-- Type Messages


type Message
    = AddNote
    | Cancel
    | DeleteNote Int
    | EditTitle String Int
    | EditContent String Int
    | SaveNote Int
    | SelectNote Int Note



--UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        AddNote ->
            ( { model | selectedNote = Nothing, notes = [ { title = "My Note ", content = "This is my new note" } ] ++ model.notes }, Cmd.none )

        Cancel ->
            ( { model | selectedNote = Nothing }, Cmd.none )

        DeleteNote id ->
            let
                newList =
                    List.removeAt id model.notes
            in
            ( { model | notes = newList }, Cmd.none )

        EditTitle text id ->
            case model.selectedNote of
                Nothing ->
                    ( model, Cmd.none )

                Just ( index, myNote ) ->
                    if index == id then
                        ( { model | selectedNote = Just ( index, { myNote | title = text } ) }, Cmd.none )

                    else
                        ( model, Cmd.none )

        EditContent text id ->
            case model.selectedNote of
                Nothing ->
                    ( model, Cmd.none )

                Just ( index, myNote ) ->
                    if index == id then
                        ( { model | selectedNote = Just ( index, { myNote | content = text } ) }, Cmd.none )

                    else
                        ( model, Cmd.none )

        SaveNote id ->
            case model.selectedNote of
                Nothing ->
                    ( model, Cmd.none )

                Just ( index, myNote ) ->
                    if id == index then
                        let
                            newList =
                                List.setAt index myNote model.notes
                        in
                        ( { model | selectedNote = Just ( index, myNote ), notes = newList }, Cmd.none )

                    else
                        ( model, Cmd.none )

        SelectNote id myNote ->
            ( { model | selectedNote = Just ( id, myNote ) }, Cmd.none )



--SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none



--VIEW


view : Model -> Html Message
view model =
    div []
        [ button [ class "btn btn-primary", onClick AddNote ] [ text "Add new note" ]
        , div [] [ text "My Note App" ]
        , div [ class "form-group" ] [ renderForm model ]
        ]


renderList : Model -> Html Message
renderList model =
    model.notes
        |> List.indexedMap
            (\index myNote ->
                div []
                    [ li
                        []
                        [ text "#Title: "
                        , text myNote.title
                        ]
                    , div []
                        [ text myNote.content
                        ]
                    , button [ onClick (SelectNote index myNote) ] [ text "Select" ]
                    , button [ onClick (DeleteNote index) ] [ text "Delete" ]
                    ]
            )
        |> ol []


renderForm : Model -> Html Message
renderForm model =
    case model.selectedNote of
        Nothing ->
            renderList model

        Just ( index, myNote ) ->
            div []
                [ label
                    []
                    [ text "Title " ]
                , input
                    [ value myNote.title
                    , onInput (\x -> EditTitle x index)
                    ]
                    []
                , label
                    []
                    [ text " Content" ]
                , input
                    [ value myNote.content
                    , onInput (\x -> EditContent x index)
                    ]
                    []
                , button [ onClick (SaveNote index) ] [ text "Save Note" ]
                , button [ onClick Cancel ] [ text "Cancel " ]
                , renderList model
                ]
