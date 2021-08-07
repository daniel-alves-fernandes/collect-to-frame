# collect_to_frame
Collect to Frame puts the information of the active collection onto a new Stata frame.


## Example

```stata
sysuse auto

collect: reg mpg rep78

collect_to_frame results1
frame change results1
```


Specify option -labels- to use labels of dimension levels instead of their names:

```
collect_to_frame results2, label
frame change results2
```

