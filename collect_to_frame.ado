/******************************************************************************
* collectFrame.ado

* author: Daniel Fernandes
* contact: daniel.fernandes@eui.eu
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
    dimensions = re.sub(r"\[[\w\d]*\]","",item[0]).split("#")
    levels = re.sub(r"([\w\d]*\[|\])","",item[0]).split("#")

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

    for col in columns:
      labels = contents["Labels"]["Dimensions"].get(col)
      try:
        stata_frame[col] = stata_frame[col].map(labels)
      except:
        pass

  # Export to .csv
  stata_frame.to_stata(stjson_file,write_index=False,variable_labels=varlabels)
end