/******************************************************************************
collectFrame.ado
version 1.1.3

author: Daniel Fernandes
contact: daniel.fernandes@eui.eu
******************************************************************************/

capture: program drop collect_to_frame
program define collect_to_frame
syntax name(name=frame id="collection"), [labels]

  * Requirements
  version 17
  capture: which python
  if (_rc == 111) error 111

  capture: which glevelsof
  if (_rc == 111){
    local command levelsof
    local parse r
  }
  else{
    local command glevelsof
    local parse J
  }

  * Confirm new frame name
  confirm new frame `frame'

  * Save .stjson file
  tempfile stjson_file
  quietly: collect save "`stjson_file'", replace

  * Convert .stjson file to workable format
  python: collect_to_frame("`stjson_file'","`labels'")

  * Note: this function uses the temporary file to store back a .csv file.
  * I opted not to use the Stata Framework Interface module (SFI) because
  * that would break compatibility with Stata in Jupyter Notebooks.

  frame create `frame'
  frame `frame': quietly: use "`stjson_file'"
end

python:
def collect_to_frame(stjson_file,mode):
  import json, re
  import pandas as pd

  # Open file
  with open(stjson_file,"r") as file:
    contents = file.read()
    contents = json.loads(contents)

  data, columns = [], set()

  # Change the structure of the .stjson file
  for item in contents["Items"].items():
    dimensions = re.sub(r"\[[\w\d#]*(\]$)?","",item[0]).split("]#")
    levels = re.sub(r"([\w\d]*\[|(\]$))","",item[0]).split("]#")

    line = dict(zip(dimensions,levels))
    line["value"] = item[1].get("d")
    data.append(line)

    columns.update(set(dimensions))

  # Stata frame
  stata_frame = pd.DataFrame(data)

  # Variable labels
  varlabels = contents["Labels"]["Dimensions"]["_dimensions"]

  # Value labels
  if mode=="labels":
    columns.update(["value"])
    valuelabels = contents["Labels"]["Dimensions"]
    
    # This transformation separates variables in interaction effects and
    # removes times series operators. This needs to be done so labels can
    # be assined properly.
    for col in columns:
      stata_frame[col] = stata_frame[col].apply(lambda x:

        " # ".join([valuelabels.get(col).get(re.sub(r"[\w\d]*\.","",i),str(x))
          for i in x.split("#")])

        if type(x) == str and type(valuelabels.get(col)) == dict
        else x
        )

  # Export to .csv
  stata_frame.to_stata(stjson_file,
    write_index=False,variable_labels=varlabels,version=119)
end
