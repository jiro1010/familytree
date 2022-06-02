
# familytree package
`jiro1010senju AT gmail DOT com`

Some LaTeX macros (or commands) to draw a familytree.


# Install

`$ make Dir=/tmp`

You will get these files under `${Dir}`.
- `familytree.sty`
- `familytree-ja.pdf`

and some samples.

- `Asai.pdf`
- `Crawley.pdf`
- `Tokugawa.pdf`


`$ make InstallDir=${HOME}/lib/texinputs install`

You will get `${InstallDir}/familytree.sty`.


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
	[list of additonal info or attributes]
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

To deinfe the siblings,
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


For more details, refer to `*.dtx` or `familytree-ja.pdf`,
and `sample/` sub-dir.
