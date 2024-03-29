%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Medium Length Professional CV - RESUME CLASS FILE
%
% This template has been downloaded from:
% http://www.LaTeXTemplates.com
%
% This class file defines the structure and design of the template. 
%
% Original header:
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
% Created by Trey Hunner and modified by www.LaTeXTemplates.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[2010/07/10 v0.9 Resume class]

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements
\usepackage[hidelinks]{hyperref}
\usepackage{etoolbox}

\pagestyle{empty} % Suppress page numbers

%----------------------------------------------------------------------------------------
%	HEADINGS COMMANDS: Commands for printing name and address
%----------------------------------------------------------------------------------------

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \title#1{\def\@title{#1}} % Defines the \title command to set title
\def \@title {} % Sets \@title to empty by default

\def \summary #1{\def\@summary{#1}} % Defines the \title command to set title
\def \@summary {} % Sets \@title to empty by default

\def \repository #1{\def\@repository{#1}} % Defines the \repository command to set the repo
\def \@repository {} % sets \@repository to empty by default

\def \addressSep {$\diamond$} % Set default address separator to a diamond

% One, two or three address lines can be specified 
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

\newcommand*{\addresslist}{}

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
  \@ifundefined{@addressthree}{
  \def \@addressthree {#1}
  }{
     \def \@addressone {#1}
  }}
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

\newcommand{\horizontalAddrs}[2][$\;\bullet\;$]{%
  \def\nextitem{\def\nextitem{#1}}% Separator
  \renewcommand*{\do}[1]{\nextitem##1}% How to process each item
  \centerline{\dolistloop{#2}}% Process list
  \par
  \addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\MakeUppercase{\namesize\bf \@name}}\hfil
    \nameskip\break
  \endgroup
}

%----------------------------------------------------------------------------------------
%	PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printname % Print the name specified with \name
 \printaddress{\@title} %print out title
  \smallskip
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \listadd{\addresslist}{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \listadd{\addresslist}{\@addresstwo}}
  \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \listadd{\addresslist}{\@addressthree}}
  \horizontalAddrs{\addresslist}
  \smallskip
  \centerline{This Resume is Code: \href{\@repository}{\@repository}} 
  \begin{center}
    \parbox{18 cm} { {\bf Summary:} \@summary}
  \end{center}
   
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \sectionskip
  \MakeUppercase{\bf #1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \begin{list}{$\cdot$}{ % List for each individual item in the section
    \setlength{\leftmargin}{1.5em} % Margin within the section
  }
  \item[]
}{
  \end{list}
}

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newenvironment{rSubsection}[6]{ % 6 input arguments - company name, location, job title, position,  employment dates, and summary
 \ifthenelse{\equal{#1}{}}{}{
 {\bf \hspace*{-1.25em}#1} --- {#2} \hfill {\bf #3} \\}% Bold company name
  \ifthenelse{\equal{#4}{}}{\null\hfill {#5}}{{\em #4} \hfill { #5}} % Italic job title and normal date
  \par \hangindent=1em
  {#6}\smallskip % summary
  \begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
   \itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
  }{
  \end{list}
  \vspace{0.5em} % Some space after the list of bullet points
}

\newenvironment{rSubsectionNoList}[6]{ % 6 input arguments - company name, locatoin, job title, position,  employment dates, and summary
 \ifthenelse{\equal{#1}{}}{}{
 {\bf \hspace*{-1.25em}#1} --- {#2} \hfill {\bf #3} \\}% Bold company name
  \ifthenelse{\equal{#4}{}}{\null\hfill {#5}}{{\em #4} \hfill { #5}} % Italic job title and normal date
  \par \hangindent=1em
  {#6}\smallskip % summary
}

% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\huge} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\smallskip} % The space above the horizontal line for each section 
\def\nameskip{\smallskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section
