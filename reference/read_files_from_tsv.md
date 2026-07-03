# Open a tsv file or multiple tsv files with a file_tag as an arrow dataset

Open a tsv file or multiple tsv files with a file_tag as an arrow
dataset

## Usage

``` r
read_files_from_tsv(file_tag, input_dir, schema = NULL)
```

## Arguments

- file_tag:

  "observation", "practice" etc.

- input_dir:

  Directory with tsv files (or in sub-directories)

- schema:

  Optional - an \`arrow::Scheme\` object to set variable types

## Value

An arrow dataset
