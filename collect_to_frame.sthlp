{smcl}
{* *! version 1.0  07ago2021}{...}

{title:Collect to frame}

{pstd}
{hi:collect_to_frame} {hline 2} puts the information of the active collection onto a new Stata frame. {it:Requires Stata 17.}

{marker syntax}{...}
{title:Syntax}

{pstd}
  {cmd:collect_to_frame} {help frame:newframe}, {bf:[{ul:label}s]}


{title:Options}

{pstd}
{bf:{ul:label}s}: uses labels of dimension levels, instead of their names.


{title:Note}

{it:This command calls a Python function to convert the data into a readable format in Stata.}
{it:Please, check if your Python installation has the following modules: json, re, pandas.}


{title:Author}

{pstd}
{it:Daniel Alves Fernandes}{break}
European University Institute

{pstd}
daniel.fernandes@eui.eu
