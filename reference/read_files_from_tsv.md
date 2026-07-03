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

  Several schemas are included in the package and accessed by passing
  \`dataset_name\` and \`table_name\` to \[get_schema()\]. You can use
  \`get_schema()\` with no arguments to list available schemas.

  You can also construct a custom schema using \[create_schema()\]

## Value

An arrow dataset
