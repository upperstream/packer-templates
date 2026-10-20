---
name: document-standards
description: Standards to follow when writing a documentation text file.
metadata:
  version: "1.1.0"
---

Here is the list of standards for documentation text files:

* Use two spaces after a full stop, except for source files of manual
  pages.  Since documentation text files are intended to be printed
  using monospace font, "double spaces are no longer necessary in
  computer era" rule cannot be applied.
* Begin every documentation sentence with a capital letter.  If a
  lower-case proper noun or identifier would begin a sentence, rephrase
  the sentence instead of changing the name's spelling.  For example,
  prefer "The `printf` function returns the number of characters..."
  over "`printf` returns the number of characters...".  This follows
  the [GNU Coding Standards][gnu-comments] and the
  [GNU Texinfo Manual][gnu-code].
* Prefer British spelling over American spelling, except for proper
  nouns and commonly used spellings.  Prefer "licensing" where
  applicable.  When a noun is needed, "license" may be used with or
  without capitalisation.  This exception applies only to "license",
  not generally to other words ending in "-ense" or "-ence".  The file
  name "LICENSE.txt" is also allowed.
* Lines should be wrapped at 72 characters: never exceed 72 characters
  unless the line is preformatted (including a code span longer than 72
  characters), contains a long URL, or is a part of a [GFM][] table.
  Trailing punctuations may appear after the 72-character limit when
  necessary.
* For Markdown files, human readability as a plain text file takes
  precedence over visual appearance as a rendered HTML.  Respect the
  "Philosophy" section in the _Markdown Syntax_ documentation on
  [Daring Fireball][].
* Use underscores (`_`) as a Markdown indicator for italicisation rather
  than asterisks (`*`) when citing a title of a work.
* Use Markdown indicator for emphasis (asterisks or underscores) only
  when it is semantically necessary.  Avoid overuse of emphasis such as:

      **Example 1**: This is an example of **too much emphasising**.

  This is preferred:

      Example 2: This is an example of fair tone expression.

[Daring Fireball]: https://daringfireball.net/projects/markdown/syntax#philosophy
  "Daring Fireball: Markdown Syntax Documentation"
[GFM]: https://github.github.com/gfm/ "GitHub Flavored Markdown Spec"
[gnu-comments]: https://www.gnu.org/prep/standards/standards.html#Comments
  "GNU Coding Standards: Comments"
[gnu-code]: https://ftp.gnu.org/old-gnu/Manuals/texinfo-4.2/html_node/code.html#code
  "GNU Texinfo Manual: `@code`"
