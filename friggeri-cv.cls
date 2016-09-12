\ProvidesClass{friggeri-cv}[2012/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@cv@print
	\colorlet{green}{gray}
	\colorlet{orange}{gray}
	\colorlet{purple}{gray}
	\colorlet{red}{gray}
	\colorlet{blue}{gray}
	\colorlet{fillheader}{white}
	\colorlet{header}{gray}
\else
	\colorlet{fillheader}{gray}
	\colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX, vargreek-shape=unicode]{unicode-math}
\RequirePackage{fontawesome}

\newfontfamily\bodyfont[]{Helvetica Neue}
\newfontfamily\thinfont[]{Helvetica Neue UltraLight}
\newfontfamily\headingfont[]{Helvetica Neue Condensed Bold}

\defaultfontfeatures{Mapping=tex-text}

\setmainfont[Mapping=tex-text, Color=textcolor]{Helvetica Neue Light}
\setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
	\fontsize{14pt}{24pt}\selectfont%
	\positionfont%
	\color{white}%
}

\newcommand{\header}[3]{%
	\begin{tikzpicture}[remember picture, overlay]
		\node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
		\node [anchor=center] (name) at (box) {%
			\fontsize{40pt}{72pt}\color{header}% SIZE HEADER FIRST LINE
			{\thinfont #1}{\bodyfont #2}
		};
		\node [anchor=north] at (name.south) {%
			\fontsize{20pt}{24pt}\color{header}% SIZE HEADER SECOND LINE
			\thinfont #3%
		};
	\end{tikzpicture}
	\vspace{2.5cm}
	\vspace{-2\parskip}
}

%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%

\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1{%
	{%
		\color{%
		\ifcase\value{colorCounter}%
			blue\or%
			red\or%
			orange\or%
			green\or%
			purple\else%
			headercolor\fi%
		} #1%
	}%
	\stepcounter{colorCounter}%
	%reset the counter once we exhaust all colours
	\ifthenelse{\equal{\value{colorCounter}}{6}}{
		\setcounter{colorCounter}{0}
	}{}
}

\renewcommand{\section}[1]{
	\par\vspace{\parskip}
	{%
		\LARGE\headingfont\color{headercolor}%
		\@sectioncolor #1%
	}
	\par\vspace{\parskip}
}

\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ifthen}

\setlength{\tabcolsep}{0pt}

\newenvironment{entrylist}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}p{2.5cm}l}%
}{%
	\end{tabular*}
}

\newenvironment{RefList}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}p{8.5cm}l}%
}{%
	\end{tabular*}
}

\renewcommand{\bfseries}{\headingfont\color{headercolor}}

% New command to add a new experience
\newcommand{\Experience}[6]{%
	#1	&	\parbox[t]{11.5cm}{	\textbf{#2}					\hfill\textbf{#3}\\%
			{\addfontfeature{Color=lightgray} \textit{#4}}	\hfill{\addfontfeature{Color=lightgray} #5}\\%
			#6												\vspace{\parsep}}\\}

% New command to insert a new "education"
\newcommand{\Education}[4]{%
	#1	&	\parbox[t]{11.5cm}{	\textbf{#2}	\hfill{\addfontfeature{Color=lightgray} #3}\\%
			#4								\vspace{\parsep}}\\}

% New command to insert 2 references
\newcommand{\Reference}[8]{%
	\textbf{#1}										&	\textbf{#5}\\%
	#2												&	#6\\%
	{\addfontfeature{Color=lightgray} \textit{#3}}	&	{\addfontfeature{Color=lightgray} \textit{#7}}\\%
	#4												&	#8\\}

%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newenvironment{aside}{%
	\let\oldsection\section
	\renewcommand{\section}[1]{
		\par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
		}
	\begin{textblock}{4.1}(0.75, 4.33)% {largeur}(pos horizontale, pos verticale)
	\begin{flushright}
	\obeycr
}{%
	\restorecr
	\end{flushright}
	\end{textblock}
	\let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

% \RequirePackage[style=verbose, maxnames=99, sorting=ydnt]{biblatex}
%
% \DeclareFieldFormat[article]{title}{#1\par}
% \DeclareFieldFormat[book]{title}{#1\par}
% \DeclareFieldFormat[inproceedings]{title}{#1\par}
% \DeclareFieldFormat[misc]{title}{#1\par}
% \DeclareFieldFormat[report]{title}{#1\par}
%
% \DeclareBibliographyDriver{article}{%
%   \printfield{title}%
%   \newblock%
%   \printnames{author}%
%   \par%
%   \newblock%
%   {%
%     \footnotesize\addfontfeature{Color=lightgray}\itshape%
%     \usebibmacro{journal+issuetitle}%
%     \setunit{\space}%
%     \printfield{pages}%
%     \newunit%
%     \printlist{publisher}%
%     \setunit*{\addcomma\space}%
%     \printfield{year}%
%     \newunit%
%   }
%   \par\vspace{0.3\baselineskip}
% }
%
% \DeclareBibliographyDriver{book}{%
%   \printfield{title}%
%   \newblock%
%   \printnames{author}%
%   \par%
%   \newblock%
%   {%
%     \footnotesize\addfontfeature{Color=lightgray}\itshape%
%     \printlist{publisher}%
%     \setunit*{\addcomma\space}%
%     \printfield{note}%
%     \setunit*{\addcomma\space}%
%     \printfield{year}%
%     \setunit{\addcomma\space}%
%     \printlist{location}%
%     \newunit%
%   }
%   \par\vspace{0.3\baselineskip}
% }
%
%
% \DeclareBibliographyDriver{inproceedings}{%
%   \printfield{title}%
%   \newblock%
%   \printnames{author}%
%   \par%
%   \newblock%
%   {%
%     \footnotesize\addfontfeature{Color=lightgray}%
%     \printfield{booktitle}%
%     \setunit{\addcomma\space}%
%     \printfield{year}%
%     \setunit{\addcomma\space}%
%     \printlist{location}%
%     \newunit%
%   }
%   \par\vspace{0.3\baselineskip}
% }
%
% \DeclareBibliographyDriver{misc}{%
%   \printfield{title}%
%   \newblock%
%   \printnames{author}%
%   \par%
%   \newblock%
%   {%
%     \footnotesize\addfontfeature{Color=lightgray}\itshape%
%     \printfield{booktitle}%
%     \setunit*{\addcomma\space}%
%     \printfield{note}%
%     \setunit*{\addcomma\space}%
%     \printfield{year}%
%     \setunit{\addcomma\space}%
%     \printlist{location}%
%     \newunit%
%   }
%   \par\vspace{0.3\baselineskip}
% }
%
% \DeclareBibliographyDriver{report}{%
%   \printfield{title}%
%   \newblock%
%   \printnames{author}%
%   \par%
%   \newblock%
%   {%
%     \footnotesize\addfontfeature{Color=lightgray}\itshape%
%     \printfield{type}%
%     \setunit{\space}%
%     \printfield{number}%
%     \setunit{\addcomma\space}%
%     \printfield{year}%
%     \newunit%
%   }
%   \par\vspace{0.3\baselineskip}
% }
%
% \DeclareNameFormat{author}{%
%   \small\addfontfeature{Color=lightgray}%
%   \ifblank{#3}{}{#3\space}#1%
%   \ifthenelse{\value{listcount}<\value{liststop}}
%     {\addcomma\space}
%     {}%
% }
%
% \defbibheading{bibheading}[\bibname]{%%    \subsubsection*{#1}%    \markboth{#1}{#1}
% }
%
% \newcommand{\printbibsection}[2]{
%   \begin{refsection}
%     \nocite{*}
%     \printbibliography[sorting=chronological, type={#1}, title={#2}, heading=bibheading]
%   \end{refsection}
% }
%
% \DeclareSortingScheme{chronological}{
%   \sort[direction=descending]{\field{year}}
%   \sort[direction=descending]{\field{month}}
% }

%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=1.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
	colorlinks=true,
	linkcolor=false,
	citecolor=false,
	filecolor=false,
	urlcolor = false}

% A fix for \href{}{} colors not working with fontspec
\makeatletter
\def\HyColor@@@@UseColor#1\@nil{\addfontfeatures{Color=#1}}
\makeatother
