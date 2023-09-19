#let fontSize = 10pt
//#let mainColor = green //rgb("#ff851b")
#let normalText = 1em
#let largeText = 3em
#let hugeText = 16em
#let title_main_1 = 2.5em
#let title_main_2 = 1.8em
#let title_main_3 = 2.2em
#let title1 = 2.2em
#let title2 = 1.5em
#let title3 = 1.3em
#let title4 = 1.2em
#let title5 = 1.1em


#let state_main_colour = state("main_colour", none)
#let state_title_font = state("state_title_font", none)
#let state_heading_font = state("state_heading_font", none)
#let chapter_image = state("chapter_image", none)
#let part_number = counter("part-number")




#let setChapterImage(img) = {
  chapter_image.update(img)
}



#let part(title) = {
  pagebreak()
  pagebreak(to: "odd", weak: true)
  
  locate(loc => [
    #let colour = state_main_colour.at(loc)
    #let titleFont = state_title_font.at(loc)
    #page(fill: colour)[
      #part_number.step()
      #set text(font: titleFont, size: 48pt, weight: "bold")
      #smallcaps([
        Part: #part_number.display() \
        #text(title)
        <part>
      ])
    ]
  ])
  pagebreak()
}

/*
#let part(title) = {
  pagebreak()
  pagebreak(to: "odd", weak: true)
  
  locate(loc => [
    #let colour = state_main_colour.at(loc)
    #page(fill: colour.lighten(70%))[
      #part_number.step()

      // Display the part number in big text
      #place(top+left)[
        #block(text(font: "DM Sans", fill: colour, size: 288pt, weight: "black", part_number.display("I")))
        #v(1cm, weak: true)
        #move(dx: -4pt, block(text(fill: colour, size: 6em, weight: "bold", title)))

      ]
    ]
  ])
  pagebreak()
}
*/




// Outline/introduction
#let my-outline-row( textSize:none,
                    textWeight: "regular",
                    textFont: none,
                    insetSize: 0pt,
                    textColor: blue,
                    number: "0",
                    title: none,
                    heading_page: "0",
                    target: none) = {
  set text(font: textFont, size: textSize, fill: textColor, weight: textWeight)
  box(width: 1.1cm, inset: (y: insetSize), align(left, number))
  h(0.1cm)
  box(inset: (y: insetSize), width: 100% - 1.2cm, )[
    #link(target, title)
    #box(width: 1fr, repeat(text(weight: "regular")[. #h(4pt)])) 
    #link(target, heading_page)
  ]
}


#let show_outline =  {
    show outline.entry: it => {
      let counterInt = counter(heading).at(it.element.location())
      let number = none
      if counterInt.first() >0 {
        number = numbering("1.1", ..counterInt)
      }
      let title = it.element.body
      let heading_page = it.page
      let colour = state_main_colour.at(it.element.location())
      let headingFont = state_heading_font.at(it.element.location())
      if it.level == 1 {
        v(1em, weak: true)
        my-outline-row(insetSize: 2pt, textWeight: "bold", textSize: 18pt, textFont: headingFont, textColor: colour, title: title, 
                       heading_page: heading_page, number: number, target: it.element.location())
      }
      else if it.level == 2 {
        my-outline-row(insetSize: 2pt, textWeight: "bold", textSize: 14pt, textFont: headingFont, textColor:black, title: title, 
                       heading_page: heading_page, number: number, target: it.element.location())
      }
      else {
        my-outline-row(insetSize: 2pt, textWeight: "regular", textSize: 12pt, textFont: headingFont, textColor:black, title: title, 
                       heading_page: heading_page, number: number, target: it.element.location())        
      }
    }
    set outline(indent: false)
    //set page(numbering: "i")
    
    
    let part-title(loc, part_title) = link(loc)[
      #let colour = state_main_colour.at(loc)
      #let titleFont = state_title_font.at(loc)
      #v(0.7cm, weak: true)
      #box(width:100%, {
        box(width: 1.1cm, fill: colour.lighten(80%), inset: 5pt, align(
            center, text(font: titleFont, size: 24pt, weight: "bold", fill: colour.lighten(30%), numbering("I", counter(<part>).at(loc).first())))) 
        h(0.1cm) 
        box(width: 100% - 1.2cm, fill: colour.lighten(60%), inset: 5pt, align(center, text(font: titleFont, size: 24pt, weight: "bold", part_title)))
      })
      #v(0.45cm, weak: true)
    ]

    heading(numbering: none, outlined: false, bookmarked: false, "Table of Contents")
    
    // Make each part have its own outline
    locate(loc => {
      let elems = query(<part>, loc)
      for i in range(0, elems.len()-1) {
        let from = elems.at(i).location()
        let to = elems.at(i+1).location()
        part-title(from, elems.at(i).text)
        outline(title: none, target: selector(heading).after(from).before(to))
      }
      part-title(elems.last().location(), elems.last().text)
      outline(title: none, target: selector(heading).after(elems.last().location()))
    })
  }

  


#let book(title: "", 
          subtitle: "", 
          author: (), 
          logo: none, 
          cover: none, 
          imageIndex:none, 
          mainColor: blue,
          copyright: [], 
          lang: "en", 
          listOfFigureTitle: none, 
          listOfTableTitle: none, 
          supplementChapter: "Chapter", 
          supplementPart: "PART", 
          titleFont: "New Computer Modern",
          headingFont: "New Computer Modern",
          bodyFont: "New Computer Modern",
          fontSize: 10pt, 
          justify: true,
          leading: 0.65em,
          part_style: 0,
          body, 
         ) = {

  // Set the meta data for the whole Document
  set document(author: author, title: title)



  
  //
  state_main_colour.update(x => mainColor)
  state_title_font.update(x => titleFont)
  state_heading_font.update(x => headingFont)
  
  /*
   * 
   * Set up the main structure of the page
   *
   */
  set page(
    paper: "a4",
    //margin: (x: 4cm, bottom: 2.5cm, top: 3cm),
    margin: (inside: 4cm, outside: 3cm, bottom: 2.5cm, top: 3cm),

    // Specify the structure of the page headers
    header: locate(loc => {
      set text(font: headingFont, size: title5)
      let page_number = counter(page).at(loc).first()
      let odd_page = calc.odd(page_number)

      // Are we on a page that starts a chapter? 
      let all = query(heading.where(level: 1), loc)
      if all.any(it => it.location().page() == page_number) {
        return
      }

      // Are we on a page that starts a part? 
      let parts = query(<part>, loc)
      if parts.any(it => it.location().page() == page_number) {
        return
      }

      // Get the array of chapters (level 1 headings) that have occured before this point
      // we need to run the query because we want the chapter title, the counter will just
      // give us the chapter number.
      let chapters = query(selector(heading.where(level: 1)).before(loc), loc)
      let mostRecentChapter = counter(heading).at(loc).first()

      let heading_text = ""
      if (chapters.len() > 0) {
        // Current chapter number
        let mostRecentChapterPage = chapters.last().location().page()

        let parts = query(selector(<part>).before(loc), loc)
        let mostRecentPartPage = 0
        if parts.len()>0 {
          mostRecentPartPage = parts.last().location().page()
          if mostRecentChapterPage > mostRecentPartPage {
            heading_text = text(weight: "bold", 
                chapters.last().supplement + " " + str(mostRecentChapter) + ". " + chapters.last().body
            )            
          }
        }
        
      }

      if odd_page {
        if chapters != () and mostRecentChapter > 0 {
          box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
            #heading_text
            #h(1fr)
            #page_number
          ]
        }
      } else{
        if chapters != () and mostRecentChapter > 0 {
          box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
            #page_number
            #h(1fr)
            #heading_text
          ]
        }
      }
    })
  )



  let showChapter(head) = {
    pagebreak(to: "odd", weak: true)
  
    locate(loc => {
      let img = chapter_image.at(loc) // get the heading image state value at this point in the file
      if img != none {
        // we have an image
        set image(width: 21cm, height: 9.4cm) // a4 paper is 210mm wide, so this image is the full width
        place(move(dx: -4cm, dy: -3cm, img)) // move up and left by the size of the margins and show the image
      }
      else {
        place(move(dx: -4cm, dy: -3cm, block(
          width: 21cm,
          height: 9.4cm,
          fill: mainColor.lighten(70%)
        ))) // move up and left by the size of the          
      }
      place(
        move(dx: -4cm, dy: -3cm, // move up and left by the size of the margins
          block(width: 21cm, height: 9.4cm, // create a block the same size as the image
            align(right + bottom, 
              pad(bottom: 1.2cm, // leave 1.2cm of image empty at the bottom
                block(
                  width: 21cm-3cm, // make it the full width minus the left margin size
                  stroke: (
                    right: none,
                    rest: 3pt + mainColor,
                  ),
                  inset: (left:2em, rest: 1.6em),
                  fill: rgb("#FFFFFFAA"),
                  radius: ( right: 0pt, left: 10pt ),
                  align(left, text(font: headingFont, size: 36pt, head)) // display the actual heading
                )
              )
            )
          )
        )
      )
      v(8.4cm)
    })  
  }
  
  show heading: it => {
    if it.level == 1 {
      //it
      showChapter(it)
    } else {
      text(font: headingFont, it)
    }
  }


  set heading(
    numbering: (..nums) => {
      let vals = nums.pos()
      if vals.len() == 1 {
        return str(vals.first()) + "."
      }
      else if vals.len() <=4 {
        let color = mainColor
        if vals.len() == 4 {
          color = black
        }
        return place(dx:-4.5cm, box(width: 4cm, align(right, text(font: headingFont, fill: color)[#nums.pos().map(str).join(".")])))
      }
    },
    supplement: supplementChapter
  );



  // Now we write the document
  //
  //

  
  //  Show a title page with a full page background
  //
  //
  //set image(width: 100%, height: 100%)
  let titleImg = image(cover, width: 100%, height: 100%)
  page(margin: 0cm, header: none, background: titleImg)[
    #set text(fill: black, font: titleFont)
    #if logo != none {
      place(top + center, pad(top:1cm, image(logo, width: 3cm)))
    }
    #align(center + horizon, 
      block(width: 100%, fill: mainColor.lighten(70%), height: 7.5cm, 
        pad(x:2cm, y:1cm)[
          #text(size: 3em, weight: 900, title)
          #v(1cm, weak: true)
          #text(size: 3em, subtitle)
          #v(1cm, weak: true)
          #text(size: 1em, weight: "bold", author)
        ]
      )
    )
  ]



  // Set default text properties
  set text(size: fontSize, lang: lang, font: bodyFont)

  set par(
    first-line-indent: 0em,
    justify: true,
    leading: leading
  )
  //show par: set block(spacing: 3.0em) // set the spacing between paragraphs
  show par: set block(above: 3.0em, below: 3em) // set the spacing between paragraphs

  // Set the numbering format for numbered lists
  set enum(numbering: "1.a.i.")

  // Set the style for unnumbered lists.
  set list(marker: ([•], [--], [◦]))

  set page(numbering: "i")

  // Show the copyright if one exists on a page of it's own
  // If there is no copyright then show a blank page.
  if (copyright!=none){
    set text(size: 10pt)
    show link: it => [
      #set text(fill: mainColor)
      #it
    ]
    show par: set block(spacing: 2em)
    pagebreak()
    align(bottom, copyright)
  } else {
  // Manually put a pagebreak in to force us to an odd page
  // to work around a bug in typst
    pagebreak()
  }

  show_outline

  set page(numbering: none)
  
  body
}



