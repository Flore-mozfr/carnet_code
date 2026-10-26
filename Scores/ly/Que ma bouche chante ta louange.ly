\version "2.26.0"
% automatically converted by musicxml2ly from /home/flore/Musique/que_ma_bouche.mxl
\pointAndClickOff

\include "articulate.ly"

%% additional definitions required by the score:
D = \tweak Stem.direction #DOWN \etc
U = \tweak Stem.direction #UP \etc


\header {
  composer = \markup \normal-text \normalsize \fontsize #-1.705
  "Florent DEBOEUF"
  "credit: 1" = \markup \normal-text \normalsize \fontsize #4.295
  "Que ma bouche chante ta louange"
  "credit: 2" = \markup \normal-text \normalsize \fontsize #-3.880 "13"
  "credit: 3" = \markup \normal-text \normalsize \fontsize #-3.880 "17"
  copyright = \markup \normal-text \normalsize \fontsize #-3.880 "22"
  poet = \markup \normal-text \normalsize \fontsize #-1.705 "Ut et Eb"
  "movement-title" =
  "© 2010, Editions de l'Emmanuel, 89 boulevard Blanqui, 75013 Paris"
  "id: composer" = "Florent DEBOEUF"
  "id: lyricist" = \markup \column {
    \line { "Zen" }
    \line { "Ut et Eb" }
  }
  "id: software" = \markup \column {
    \line { "Audiveris 5.11.0" }
    \line { "ProxyMusic 4.0.3" }
  }
}
#(set-global-staff-size 13.490305157480314)
\paper {
  paper-width = 21\cm
  paper-height = 29.7\cm
  top-margin = 0.95\cm
  bottom-margin = 0.95\cm
  left-margin = 0.95\cm
  right-margin = 0.95\cm
  indent = 1.76\cm
  short-indent = 1.76\cm
}
\layout {
  \context {
    \Staff
    printKeyCancellation = ##f
  }
  \context {
    \Score
    doubleRepeatBarType = ":|.|:"
    autoBeaming = ##f
  }
}
PartPOneVoiceOne = {
  \clef
  "treble"
  \time 4/4
  \U g'8. [ \U g'16 _~ ] \U g'8 [ \U a'8 ] \U g'8. [
  \U e'16 _~ ] \U e'8 [ \U c'8 ] | % 1
  \U f'8. [ \U f'16 _~ ] \U f'8 [ \U a'8 ] \U g'4 \U c'8 [ \U d'8 ] | % 2
  \U e'4 \U g'4 \U a'8 [ \U g'8 \U e'8 \U d'8 ] | % 3
  \U e'4 _( \U d'4 ) \U c'2 \break | % 4
  \U g'8. [ \U g'16 _~ ] \U g'8 [ \U a'8 ] \U g'8. [ \U e'16 _~ ] \U e'8 [ \U c'8 ] | % 5
  \U f'8. [ \U f'16 _~ ] \U f'8 [ \U a'8 ] \U g'4 \U c'8 [ \U d'8 ] | % 6
  \U e'4 \U g'4 \U a'8 [ \U g'8 \U e'8 \U d'8 ] | % 7
  \U e'4 _( \U d'4 ) \U c'2 \break | % 8
  \D c''8. [ \D c''16 ^~ ] \D c''8 [ \D c''8 ] \U a'8. [ \U g'16 _~ ] \U g'8 [
  \U f'8 ] | % 9
  \barNumberCheck #10
  \U g'8. [ \U g'16 _~ _. ] \U g'8 [ \U a'8 ] \U e'4 \U c'8 [ \U d'8 ] | % 10
  \U e'4 \U g'4 \U a'8 [ \U g'8 \U e'8 \U d'8 ] | % 11
  \U e'4 _( \U d'4 ) \U c'2 \break | % 12

  \break \D c''8. [ \D c''16 ^~ ] \D c''8 [ \D c''8 ] \U a'8. [ \U g'16 _~ ] \U
  g'8 [ \U f'8 ] | % 13
  \U g'8. [ \U g'16 _~ ] \U g'8 [ \U a'8 ] \U e'4 \U c'8 [ \U d'8 ] | % 14
  \U e'4 \U g'4 \U a'8 [ \U g'8 \U e'8 \U d'8 ] | % 15
  \U e'4 _( \U d'4 ) \U c'4 \U e'8 [ \U g'8 ] \break | % 16
  \break \U a'4. \U g'8 \U g'2 | % 17
  \D b'8. [ \D b'16 ^~ ] \D b'8 [ \D c''8 ] \D c''4 \U e'8 [ \U g'8 ] | % 18
  \U a'4 _~ \U a'8 [ \U g'8 ] \U g'8. [ \U e'16 _~ ] \U e'8 [ \U g'8 ] | % 19

  \barNumberCheck #20
  \U g'2. \D c''8 [ \D b'8 ] | % 20
  \U a'4. \U g'8 \U g'2 \break | % 21
  \D b'8. [ \D b'16 ^~ ] \D b'8 [ \D c''8 ] \D c''4 \U e'8 [ \U g'8 ] | % 22
  \U a'4 _~ \U a'8 [ \U g'8 ] \U g'8. [ \U e'16 _~ ] \U e'8 [ \U g'8 ] | % 23
  \U g'2. \U c'8 [ \U d'8 ] | % 24
  \U e'4 \U g'4 \U a'8 [ \U g'8 \U e'8 \U d'8 ] | % 25
  \U e'4 \U d'4 \U c'2 _>
}

PartPOneVoiceOneLyricsOne = \lyricmode {
  \set ignoreMelismata = ##t
  \set includeGraceNotes = ##t
  De Toi \skip1 Sei -- "gneur," nous \skip1 at -- ten -- dons \skip1 la "vie,"
  Que ma bou -- che chan -- te ta lou -- an -- \skip1 "ge."
  Tu es \skip1 \skip1 pour nous un \skip1 rem -- "part," un ap -- "pui,"
  Que ma bou -- che chan -- te ta lou -- an -- \skip1 "ge."
  La joie \skip1 du coeur vient \skip1  de Toi  ô Sei -- \skip1 "gneur,"
  Que ma bou -- Che chan -- te ta lou -- an -- \skip1 "ge."
  No -- tre \skip1 con -- fiance est \skip1 dans Ton nom \skip1 "trés" Saint
  Que ma bou -- che chan -- te ta lou -- an -- \skip1 "ge,"
  Sois lou --"é" Sei -- "gneur," pour ta -- \skip1 grand -- eur
  Sois -- lou -- "é" \skip1 pour tous tes \skip1 bien -- "faits."
  "Gloire" à  Toi Sei -- "gneur," tu es \skip1 vain -- "queur,
  Ton" \skip1 a -- mour \skip1 i -- non --  de nos \skip1 "coeurs."
  Que ma bou -- che chan -- te ta lou --  \skip1 an -- ge
}

PartPTwoVoiceOne = {
  \clef "treble"
  \key a \major
  \time 4/4
  \D e''8. [ \D e''16 ^~ ] \D e''8 [ \D
  fis''8 ] \D e''8. [ \D cis''16 ^~ ] \D cis''8 [ \D a'8 ] | % 1
  \D d''8. [ \D d''16 ^~ ] \D d''8 [ \D fis''8 ] \D e''4 \U a'8 [ \U b'8 ] | % 2
  \D cis''4 \D e''4 \D fis''8 [ \D e''8 \D cis''8 \D b'8 ] | % 3
  \D cis''4 \D b'4 \U a'2 \break | % 4
  \D e''8. [ \D e''16 ^~ ] \D e''8 [ \D fis''8 ] \D e''8. [ \D cis''16 ^~ ] \D
  cis''8 [ \D a'8 ] | % 5
  \D d''8. [ \D d''16 ^~ ] \D d''8 [ \D fis''8 ] \D e''4 \U a'8 [ \U b'8 ] | % 6
  \D cis''4 \D e''4 \D fis''8 [ \D e''8 \D cis''8 \D b'8 ] | % 7
  \D cis''4 ^( \D b'4 ) \U a'2 \break | % 8
  \D a''8. [ \D a''16 ^~ ] \D a''8 [ \D a''8 ] \D fis''8. [ \D e''16 ^~ ] \D
  e''8 [ \D d''8 ] | % 9

  \barNumberCheck #10
  \D e''8. [ \D e''16 ^~ ] \D e''8 [ \D fis''8 ] \D cis''4 \U a'8 [ \U b'8 ] | % 10
  \D cis''4 \D e''4 \D fis''8 [ \D e''8 \D cis''8 \D b'8 ] | % 11
  \D cis''4 ^( \D b'4 ) \U a'2 \break | % 12
  \break \D a''8. [ \D a''16 ^~ ] \D a''8 [ \D a''8 ] \D fis''8. [
  \D e''16 ^~ ] \D e''8 [ \D d''8 ] | % 13
  \D e''8. [ \D e''16 ^~ ] \D e''8 [ \D fis''8 ] \D cis''4 \U a'8 [ \U b'8 ] | % 14
  \D cis''4 \D e''4 \D fis''8 [ \D e''8 \D cis''8 \D b'8 ] | % 15
  \D cis''4 ^( \D b'4 ) \U a'4 \D cis''8 [ \D e''8 ] \break | % 16
  \break \D fis''4. \D e''8 \D e''2 | % 17
  \D gis''8. [ \D gis''16 ] \D gis''8 [ \D a''8 ] \D a''4 \D cis''8 [ \D e''8
  ] | % 18
  \D fis''4 ^~ \D fis''8 [ \D e''8 ] \D e''8. [ \D cis''16 ] \D cis''8 [ \D
  e''8 ] | % 19

  \barNumberCheck #20
  \D e''2. \D a''8 [ \D gis''8 ] | % 20
  \D fis''4. \D e''8 \D e''2 \break | % 21
  \D gis''8. [ \D gis''16 ] \D gis''8 [ \D a''8 ] \D a''4 \D cis''8 [ \D e''8
  ] | % 22
  \D fis''4 ^~ \D fis''8 [ \D e''8 ] \D e''8. [ \D cis''16 ] \D cis''8 [ \D
  e''8 ] | % 23
  \D e''2. \U a'8 [ \U b'8 ] | % 24
  \D cis''4 \D e''4 \D fis''8 [ \D e''8 \D cis''8 \D b'8 ] | % 25
  \D cis''4 \D b'4 \U a'2
}



% The score definition

\score {
  \unfoldRepeats \articulate {
    \new Staff = "P1" <<
      \set Staff.instrumentName = "Ut"
      \set Staff.shortInstrumentName = "Ut"
      \set Staff.midiInstrument = "oboe"
      \context Staff <<
        \override Staff.BarLine.allow-span-bar = ##f
        \mergeDifferentlyDottedOn
        \mergeDifferentlyHeadedOn
        \context Voice = "PartPOneVoiceOne" {
          \PartPOneVoiceOne
        }
        \new Lyrics \lyricsto "PartPOneVoiceOne" {
          \PartPOneVoiceOneLyricsOne
        }
      >>
    >>
    \new Staff = "P2" <<
      \set Staff.instrumentName = "E1)"
      \set Staff.shortInstrumentName = "E1)"
      \set Staff.midiInstrument = "clarinet"
      \context Staff <<
        \override Staff.BarLine.allow-span-bar = ##f
        \mergeDifferentlyDottedOn
        \mergeDifferentlyHeadedOn
        \context Voice = "PartPTwoVoiceOne" {
          \PartPTwoVoiceOne
        }
      >>
    >>

  }
  \midi {
    \tempo 4 = 100
  }
}

