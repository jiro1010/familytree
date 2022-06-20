
# familytree package
`jiro1010senju AT gmail DOT com`

---
```
This package is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

This package is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this package.  If not, see <http://www.gnu.org/licenses/>.
```
---

Some LaTeX macros (or commands) to draw a family tree.


# Install

`$ make Dir=/tmp`

You will get these files under `/tmp`.
```
familytree.sty
familytree.pdf
familytree-ja.pdf
Crawley.pdf
Asai.pdf
Tokugawa.pdf
```

`$ make InstallDir=/tmp/texmf-dist install`

You will get these under `/tmp/texmf-dist`.

```
tex/latex/familytree.sty
source/latex/familytree/familytree.pdf
source/latex/familytree/familytree-ja.pdf
source/latex/familytree/Crawley.pdf
source/latex/familytree/Asai.pdf
source/latex/familytree/Tokugawa.pdf
```


# Usage

1.
```
\indvdldef{Harry}{Harry}
\indvdldef{Lily}{Lily}[\matrilineal]
\pcdef{Potters}{Lily}{Harry}
\fbox{\usebox{\Potters}}
```

2.
```
\indvdldef{Petunia}{Petunia}
\indvdldef{Lily}{Lily}
\sblngdef{sis}{Petunia,Lily}
\fbox{\usebox{\sis}}
```

3.
```
\indvdldef{Lily}{Lily}
\indvdldef[\blank]{James}{James Potter}[\haschild]
\mrrgdef{Potters}{James}{Lily}{}
\fbox{\usebox{\Potters}}
```

4.
```
\indvdldef{Petunia}{Petunia}
\indvdldef[\blank]{Vernon}{Vernon Dursley}[\haschild]
\mrrgdef{Dursleys}{Vernon}{Petunia}{}
%\fbox{\usebox{\Dursleys}}

\newsavebox{\boxA}
\savebox{\boxA}{\hbox{Petunia}}
\indvdldef{Lily}{\hbox to \wd\boxA{Lily}}
\indvdldef[\blank]{James}{James Potter}[\haschild]
\mrrgdef{Potters}{}{Lily}{James}[\dimexpr\wd\Vernon - \wd\James\relax]
%\fbox{\usebox{\Potters}}

\sblngdef{sis}{Dursleys,ivali,Potters}
\fbox{\usebox{\sis}}
```


# Syntax

To define an individual,
```
\indvdldef
	[child mark]
	{new box name}
	[title]
	{individual name}
	[list of additional info or attributes]
	[maleline xlength]
```

- child mark
  + `\ftbiological`
  + `\ftadopted`
  + `\fttop`
  + `\ftblank`

- attribute
  + `\fthaschild`
  + `\ftprivate`
  + `\ftmaleline, \ftfemaleline, \ftpatrilineal, \ftmatrilineal`

---

To define the siblings,
```
\sblngdef
	{new box name}
	{name list of individual boxes}
```

You can insert the "interval box" in the name list, to make the
spaces between the siblings.

To define the interval box,
```
\ivaldef
	{box-name}
	{length}
```

There are three pre-defined interval boxes, `\ival`, `\ivali`, and `\ivalii`.

---

To define a parent-child relationship,
```
\pcdef
	{new box name}
	{parent box name}
	{child box name}
```

To define the generations,
```
\gensdef
	{new box name}
	{parent box name}
	{list of connection-pair}
```

```
connection-pair :=
	{individual box name in the parent box}
	{child box name}
```

---

To define a married couple or the spouses,
```
\mrrgdef
	{new box name}
	{spouse list A}
	{oneself}
	{spouse list B}
	[childline xlength]
```


Configuration
-------------

```
\nameboxcfg
	{space from the child mark}
	{font}
	{space to the maleline}
	{maleline length}

\cmarkboxcfg
	{space between two lines, for adopted}
	{line length}

\titleboxcfg
	{indent}
	{font}
	{linestretch}
	{vspace to the individual name}

\optboxcfg
	{vspace from the individual name}
	{indent}
	{font}
	{linestretch}

\sblngboxcfg
	{space-length}
```


For more details, refer to `*.dtx`, `familytree.pdf` or `familytree-ja.pdf`,
and `samples/` sub-dir.
