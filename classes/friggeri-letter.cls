\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{friggeri-letter}[2016/12/06 Cover letter for a resume based on friggeri template]

\DeclareOption{print}{\def\@coverletter@print{}}
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{letter}%
}
\ProcessOptions\relax
\LoadClass{letter}

%%%%%%%%%%%%
% Packages %
%%%%%%%%%%%%

\RequirePackage[french, english]{babel}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{tikz}
\RequirePackage[quiet]{fontspec}
\RequirePackage{fontawesome}
\RequirePackage[math-style=TeX, vargreek-shape=unicode]{unicode-math}
\RequirePackage{ifthen}
\RequirePackage{parskip}
\RequirePackage[absolute, overlay]{textpos}
\RequirePackage[left=2cm, top=2cm, right=1.5cm, bottom=1.5cm, nohead, nofoot]{geometry}
\RequirePackage{hyperref}

%%%%%%%%%%%%%%%%
% NEW COMMANDS %
%%%%%%%%%%%%%%%%

% \checkjobname : stop compiling if jobname is not french or english
\newcommand{\checkjobname}{%
	\newcounter{foo}
	\setcounter{foo}{0}
	\ifnum\pdfstrcmp{\jobname}{french}=0
		\selectlanguage{french}
		\stepcounter{foo}
	\fi
	\ifnum\pdfstrcmp{\jobname}{english}=0
		\selectlanguage{english}
		\stepcounter{foo}
	\fi
	\ifnum\the\value{foo}=0
		\message{Error : bad jobname ! Must be : french or english !}
		\stop
	\fi
}

% this is the macro to define phrases in two languages:
\newcommand{\trad}[2]{%
	\expandafter\ifstrequal\expandafter{\jobname}{french}{%
		#1%
	}{%
		#2%
	}%
}%

\newcommand*{\header}[3]{
	\def\firstname{#1}
	\def\lastname{#2}
	\def\subtitle{#3}
}

%%%%%%%%%%
% Colors %
%%%%%%%%%%

\definecolor{white}{RGB}{255,255,255}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@coverletter@print
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

\newfontfamily\bodyfont[]{Helvetica Neue}
\newfontfamily\thinfont[]{Helvetica Neue UltraLight}
\newfontfamily\headingfont[]{Helvetica Neue Condensed Bold}

\defaultfontfeatures{Mapping=tex-text}

\setmainfont[Mapping=tex-text, Color=textcolor]{Helvetica Neue Light}
\setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

%The letter template changes where current page.north is
%let's reset it
\setlength\headheight{0\p@}

\newcommand{\object}[1]{
	\textbf{\trad{Objet}{Subject}} : #1
}

\renewcommand*{\opening}[2]{
	\begin{tikzpicture}[remember picture, overlay]
		\node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
		\node [anchor=center] (name) at (box) {%
			\fontsize{40pt}{72pt}\color{header}%
			{\thinfont\firstname}{\bodyfont\lastname}
		};
		\node [anchor=north] at (name.south) {%
			\fontsize{20pt}{24pt}\color{header}%
			\thinfont\subtitle%
		};
	\end{tikzpicture}
	\vspace{2.5cm}
	\vspace{-2\parskip}

	\setlength{\tabcolsep}{0pt}

	\begin{tabular*}{14.5cm}[t]{p{0.75\textwidth}l}
		\fromaddress &  \\
		& \toname \\
		& \begin{minipage}{7.25cm}\toaddress\end{minipage}\\
		& \\
		& \@date \\
		& \\
		\object{#1} & \\
		& \\
	\end{tabular*}

	#2

}

\renewcommand{\closing}[2]{\par\nobreak\vspace{\parskip}
	\stopbreaks
	\noindent
	\ifx\@empty\fromaddress\else
	\hspace*{\longindentation}\fi
	\parbox{\textwidth}{\raggedright
	\ignorespaces #1\\[6\medskipamount]%
	\ignorespaces\hspace{0.66\textwidth} #2\\[6\medskipamount]%
	\ifx\@empty\fromsig
	\fromname
	\else \fromsig \fi\strut}%
	\par
}

\pagestyle{empty}
