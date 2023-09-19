#import("/book-template/book_template.typ"): book, part, setChapterImage

#show: book.with(
  title: "Exploring the Physical Manifestation of Humanity’s Subconscious Desires",
  subtitle: "A Practical Guide",
  author: "Goro Akechi",
  titleFont: "Berlin Sans FB",
  headingFont: "Berlin Sans FB",
  bodyFont: "Gentium Plus",
  fontSize: 12pt,
  leading: 0.65em,
  cover: "/examples/book-template/rm175-noon-02.jpg",
  logo: "/examples/book-template/vecteezy_free-vector-flat-graphic-designer-logo-collection_18716372.svg",
  mainColor: rgb("#799a9c"),
  copyright: [
    Copyright © 2023 Flavio Barisi

    PUBLISHED BY PUBLISHER

    #link("https://github.com/flavio20002/typst-orange-template", "TEMPLATE-WEBSITE")

    Licensed under the Apache 2.0 License (the “License”).
    You may not use this file except in compliance with the License. You may obtain a copy of
    the License at https://www.apache.org/licenses/LICENSE-2.0. Unless required by
    applicable law or agreed to in writing, software distributed under the License is distributed on an
    “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.

    Logo by Vecteezy (#link("https://www.vecteezy.com/free-vector/logo-svg") Logo Svg Vectors by Vecteezy

    Title background using assets from Freepik.com

    Chapter Images and design insipration from the LaTeX Legrand Orange Book: 
    https://www.latextemplates.com/template/legrand-orange-book

    _First printing, July 2023_
  ]
)

#part("First Part")

This is the preamble to part 1

#lorem(243)

#setChapterImage(image("orange1.jpg"))
= Introduction

#lorem(50)

#lorem(120)

#lorem(90)

#lorem(200)


== Background

#lorem(50)

#lorem(320)

#lorem(150)

#setChapterImage(image("orange2.jpg"))
= Research Objectives

#lorem(50)

#lorem(120)

#lorem(90)

#lorem(200)


== Experimental Design

#lorem(50)

#lorem(320)

#lorem(150)

=== Racing aardvarks for fun and profit.

#lorem(50)

#lorem(50)

#lorem(120)






#part("Second Part")

#lorem(97)

#setChapterImage(image("orange3.jpg"))
= Results

#lorem(50)

#lorem(120)

#lorem(90)

#lorem(200)


== Aardvarks are faster than expected

#lorem(50)

#lorem(320)

#lorem(150)


=== I need to get fitter.

#lorem(50)

#lorem(50)

#lorem(120)


